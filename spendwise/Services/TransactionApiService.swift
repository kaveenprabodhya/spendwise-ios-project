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
    
    static func createTransaction(currentUser: User, transaction: BudgetTransaction, completion: @escaping (Result<BudgetTransaction, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let transactionType: String
        switch transaction.type {
        case .income:
            transactionType = "income"
        case .expense:
            transactionType = "expense"
        }
        
        // Prepare the request body using the provided transaction data
        let requestBody: [String: Any] = [
            "id": transaction.id.uuidString,
            "type": transactionType,
            "transaction": [
                "id": transaction.transaction.id.uuidString,
                "date": transaction.transaction.date,
                "budgetType": transaction.transaction.budgetType.rawValue,
                "budgetCategory": transaction.transaction.budgetCategory,
                "amount": transaction.transaction.amount,
                "description": transaction.transaction.description,
                "paymentMethod": transaction.transaction.paymentMethod,
                "location": transaction.transaction.location,
                "attachment": [
                    "name": transaction.transaction.attachment.name
                ],
                "recurring": [
                    "frequency": transaction.transaction.recurring.frequency,
                    "date": transaction.transaction.recurring.date
                ]
            ],
            "userId": currentUser.id.uuidString
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
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
            case 201:
                // 201 Created status indicates successful creation
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let createdTransaction = try decoder.decode(BudgetTransaction.self, from: data)
                        completion(.success(createdTransaction))
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
    
    static func updateTransaction(currentUser: User, transaction: BudgetTransaction, completion: @escaping (Result<BudgetTransaction, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions/transaction-id") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let transactionType: String
        switch transaction.type {
        case .income:
            transactionType = "income"
        case .expense:
            transactionType = "expense"
        }
        
        let requestBody: [String: Any] = [
            "id": transaction.id.uuidString,
            "type": transactionType,
            "transaction": [
                "id": transaction.transaction.id.uuidString,
                "date": transaction.transaction.date,
                "budgetType": transaction.transaction.budgetType.rawValue,
                "budgetCategory": transaction.transaction.budgetCategory,
                "amount": transaction.transaction.amount,
                "description": transaction.transaction.description,
                "paymentMethod": transaction.transaction.paymentMethod,
                "location": transaction.transaction.location,
                "attachment": [
                    "name": transaction.transaction.attachment.name
                ],
                "recurring": [
                    "frequency": transaction.transaction.recurring.frequency,
                    "date": transaction.transaction.recurring.date
                ]
            ],
            "userId": currentUser.id.uuidString
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(.invalidData))
            return
        }
        
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
            case 200:
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let updatedTransaction = try decoder.decode(BudgetTransaction.self, from: data)
                        completion(.success(updatedTransaction))
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
    
    static func deleteTransaction(currentUser: User, transactionId: UUID, completion: @escaping (Result<HTTPURLResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url/user-id/transactions/transaction-id") else {
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
}
