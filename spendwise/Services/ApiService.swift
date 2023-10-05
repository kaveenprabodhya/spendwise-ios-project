//
//  ApiService.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-13.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case networkError(Error)
    case noData
    case apiError(Error)
    case invalidData
    case unauthorized
    case unknownError
    case badRequest
}

class ApiService {
    static func fetchBudgetData(completion: @escaping (Result<[Budget], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/budgets/user-id") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Successful response, parse the budget data from the response
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    // Decode the response data into an array of Budget objects
                    let decoder = JSONDecoder()
                    let budgets = try decoder.decode([Budget].self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(budgets))
                } catch {
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func fetchAmountSpentForLast7Days(completion: @escaping (Result<[SpentAmountForPreviousSevenDays], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/charts/spentAmountForPrevoiusSevenDays") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Successful response, parse the spent amount data from the response
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    // Decode the response data into an array of SpentAmountForPreviousSevenDays objects
                    let decoder = JSONDecoder()
                    let spentAmounts = try decoder.decode([SpentAmountForPreviousSevenDays].self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(spentAmounts))
                } catch {
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func authenticate(email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/authenticate") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Authentication successful, parse the user data from the response
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data!)
                    UserManager.shared.setUser(user)
                    completion(.success(user))
                } catch {
                    // Error parsing user data
                    completion(.failure(.decodingError))
                }
            case 401:
                // Unauthorized, handle authentication failure
                completion(.failure(.unauthorized))
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func register(name: String, email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/register") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Registration successful, parse the user data from the response
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: data!)
                    UserManager.shared.setUser(user)
                    completion(.success(user))
                } catch {
                    // Error parsing user data
                    completion(.failure(.decodingError))
                }
            case 400:
                // Bad request, handle registration failure (e.g., duplicate email)
                completion(.failure(.badRequest))
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func fetchOverallBudgetForUser(currentUser: User, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/budget/user-id/overall") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Successful response, parse the budget data from the response
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    // Decode the response data into an array of Budget objects
                    let decoder = JSONDecoder()
                    let overallBudget = try decoder.decode(BudgetOverViewForUser.self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(overallBudget))
                } catch {
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func fetchPreviousMonthSpentAmountRelatedToCurrentPeriod(currentUser: User, completion: @escaping (Result<PreviousMonthSpentAmountRelatedToCurrentPeriod, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/charts/previousMonthSpentAmountRelatedToCurrentPeriod") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Successful response, parse the budget data from the response
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    // Decode the response data into an array of Budget objects
                    let decoder = JSONDecoder()
                    let previousMonthSpentAmount = try decoder.decode(PreviousMonthSpentAmountRelatedToCurrentPeriod.self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(previousMonthSpentAmount))
                } catch {
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func fetchOngoingWeekExpenseAndIncomeByDay(currentUser: User, completion: @escaping (Result<[OngoingWeekExpensesByDay], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/charts/ongoingWeekExpenseAndIncomeByDay") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Successful response, parse the budget data from the response
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    // Decode the response data into an array of Budget objects
                    let decoder = JSONDecoder()
                    let weekExpenses = try decoder.decode([OngoingWeekExpensesByDay].self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(weekExpenses))
                } catch {
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
}
