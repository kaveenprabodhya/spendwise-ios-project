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

class BudgetApiService {
    static func fetchAllBudgetDataForUser(currentUser: User, completion: @escaping (Result<[Budget], NetworkError>) -> Void) {
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/\(currentUser.id)/budgets") else {
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
                    print(budgets)
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
    
    static func fetchOverallBudgetForUser(currentUser: User, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/\(currentUser.id)/budgets/overall") else {
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
    
    static func createBudget(currentUser: User, budget: Budget, completion: @escaping (Result<Budget, NetworkError>) -> Void) {
        print("inside create budget")
        guard let url = URL(string: "https://app-spendwise-org.onrenderom/\(currentUser.id)/budgets") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the request body
        let requestBody: [String: Any] = [
            "id": budget.id.uuidString,
            "name": budget.name,
            "budgetType": [
                "type": budget.budgetType.type.rawValue,
                "date": budget.budgetType.date.stringValue() ?? "",
                "limit": budget.budgetType.limit
            ],
            "category": [
                "id": budget.category.id.uuidString,
                "name": budget.category.name,
                "primaryBackgroundColor": budget.category.primaryBackgroundColor,
                "iconName": budget.category.iconName
            ],
            "allocatedAmount": budget.allocatedAmount,
            "currentAmountSpent": budget.currentAmountSpent,
            "numberOfDaysSpent": budget.numberOfDaysSpent,
            "footerMessage": [
                "message": budget.footerMessage.message,
                "warning": budget.footerMessage.warning
            ],
            "userId": budget.userId,
            // Assuming BudgetTransaction conforms to Codable, you can encode transactions here.
            "transactions": budget.transactions
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            print(request.httpBody ?? "nil")
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
            case 201:
                // Budget creation successful, parse the response data into BudgetOverViewForUser
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let budgetOverview = try decoder.decode(Budget.self, from: data)
                    completion(.success(budgetOverview))
                } catch {
                    print("decode error")
                    // Handle data decoding error
                    completion(.failure(.decodingError))
                }
            default:
                print("unkonwn")
                // Handle other HTTP status codes
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func updateBudget(currentUser: User, budget: Budget, completion: @escaping (Result<Budget, NetworkError>) -> Void) {
        print("inside update budget")
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/\(currentUser.id)/budgets/budget-id") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the request body using the provided budget data
        let requestBody: [String: Any] = [
            "id": budget.id.uuidString,
            "name": budget.name,
            "budgetType": [
                "type": budget.budgetType.type.rawValue,
                "date": budget.budgetType.date.stringValue() ?? "",
                "limit": budget.budgetType.limit
            ],
            "category": [
                "id": budget.category.id.uuidString,
                "name": budget.category.name,
                "primaryBackgroundColor": budget.category.primaryBackgroundColor,
                "iconName": budget.category.iconName
            ],
            "allocatedAmount": budget.allocatedAmount,
            "currentAmountSpent": budget.currentAmountSpent,
            "numberOfDaysSpent": budget.numberOfDaysSpent,
            "footerMessage": [
                "message": budget.footerMessage.message,
                "warning": budget.footerMessage.warning
            ],
            "userId": budget.userId,
            // Assuming BudgetTransaction conforms to Codable, you can encode transactions here.
            "transactions": budget.transactions
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle invalid HTTP response
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Budget update successful, parse the response data into Budget
                guard let data = data else {
                    // Handle empty response data
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let updatedBudget = try decoder.decode(Budget.self, from: data)
                    completion(.success(updatedBudget))
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
    
    static func deleteBudget(currentUser: User, budgetId: UUID, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void) {
        print("inside delete budget")
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/\(currentUser.id)/budgets/budget-id") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 204:
                // 204 No Content status indicates successful deletion
                completion(.success(httpResponse))
            default:
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    static func getTransactionForBudget(currentUser: User, budgetId: UUID, completion: @escaping (Result<[BudgetTransaction], NetworkError>) -> Void) {
        print("inside get trnasaction for budget budget")
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/\(currentUser.id)/budgets/budget-id/transactions") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let transactions = try decoder.decode([BudgetTransaction].self, from: data)
                        completion(.success(transactions))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                } else {
                    completion(.failure(.noData))
                }
            default:
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
}
