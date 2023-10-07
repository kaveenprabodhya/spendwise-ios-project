//
//  AuthenticationViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-03.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isAuthenticated: Bool = false
    @Published var errorEmail: String? = nil
    @Published var errorPassword: String? = nil
    @Published var errorMessage: String? = nil
    @Published var email: String = ""
    @Published var password: String = ""

    func authenticate() {
        let isEmailValid = isValidEmail(email)
        let isPasswordValid = isValidPassword(password)
        
        if !isEmailValid {
            errorEmail = "Invalid email. Please enter a valid email."
        } else {
            errorEmail = nil
        }
        
        if !isPasswordValid {
            errorPassword = "Invalid password. Password must be at least 6 characters long."
        } else {
            errorPassword = nil
        }
        
        AuthApiService.authenticate(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    self.isAuthenticated = true
                    self.errorMessage = nil
                case .failure(let error):
                    self.user = nil
                    self.isAuthenticated = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        if email.isEmpty {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        if password.isEmpty {
            return false
        }
        return password.count >= 6
    }
}
