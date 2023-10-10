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
        guard let url = URL(string: "https://your-api-url/user-id/budgets") else {
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

    static func fetchOverallBudgetForUser(currentUser: User, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/budget/overall") else {
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
    
    static func createBudget(currentUser: User, budget: Budget, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        print("inside create budget")
        guard let url = URL(string: "https://your-api-url/user-id/budgets") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func updateBudget(currentUser: User, budget: Budget, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        print("inside update budget")
        guard let url = URL(string: "https://your-api-url/user-id/budgets/budget-id") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func deleteBudget(currentUser: User, budgetId: UUID, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        print("inside delete budget")
        guard let url = URL(string: "https://your-api-url/user-id/budgets/budget-id") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func getTransactionForBudget(currentUser: User, budgetId: UUID, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        print("inside get trnasaction for budget budget")
        guard let url = URL(string: "https://your-api-url/user-id/budgets/budget-id/transactions") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
}
