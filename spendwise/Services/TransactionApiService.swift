//
//  TransactionApiService.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-07.
//

import Foundation

class TransactionApiService {
    static func fetchAllTransactionDataForUser(currentUser: User, completion: @escaping (Result<[BudgetTransaction], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions/") else {
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
                    let budgetTransactions = try decoder.decode([BudgetTransaction].self, from: data)
                    // Call the completion handler with the decoded data
                    completion(.success(budgetTransactions))
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
    
    static func createTransaction(currentUser: User, transaction: BudgetTransaction, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func updateTransaction(currentUser: User, transaction: BudgetTransaction, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions/transaction-id") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func deleteTransaction(currentUser: User, transactionId: UUID, completion: @escaping (Result<BudgetOverViewForUser, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions/transaction-id") else {
            completion(.failure(.invalidURL))
            return
        }
    }
}
