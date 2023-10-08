//
//  ChartApiService.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-07.
//

import Foundation


class ChartApiService {
    static func fetchAmountSpentForLast7Days(currentUser: User, completion: @escaping (Result<[SpentAmountForPreviousSevenDays], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/charts/spentAmountForPrevoiusSevenDays") else {
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
    
    static func fetchPreviousMonthSpentAmountRelatedToCurrentPeriod(currentUser: User, completion: @escaping (Result<PreviousMonthSpentAmountRelatedToCurrentPeriod, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/charts/previousMonthSpentAmountRelatedToCurrentPeriod") else {
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
        guard let url = URL(string: "https://your-api-url/user-id/charts/ongoingWeekExpenseAndIncomeByDay") else {
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
