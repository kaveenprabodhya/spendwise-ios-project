//
//  AuthApiService.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-07.
//

import Foundation

class AuthApiService {
    static func authenticate(email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "https://app-spendwise-org.onrender.com/authenticate") else {
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
                    print("success setting user")
                    completion(.success(user))
                } catch {
                    print("decode error")
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
}
