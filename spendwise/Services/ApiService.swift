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
}

class ApiService {
    static func fetchBudgetData(completion: @escaping (Result<[Budget], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url") else {
            completion(.failure(.invalidURL))
            return
        }
    }
    
    static func fetchAmountSpentForLast7Days(completion: @escaping (Result<[SpentAmountForPreviousSevenDays], NetworkError>) -> Void) {
        guard let url = URL(string: "https://your-api-url") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                completion(.failure(.networkError(error)))
                return
            }
            
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
        }.resume() // Don't forget to resume the data task
    }
    
    static func authenticate(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
            
    }
}
