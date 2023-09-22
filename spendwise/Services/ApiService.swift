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
    }
}
