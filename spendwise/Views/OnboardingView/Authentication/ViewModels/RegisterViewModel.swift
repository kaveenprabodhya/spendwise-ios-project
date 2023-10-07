//
//  RegisterViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-03.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isAuthenticated: Bool = false
    @Published var errorName: String? = nil
    @Published var errorEmail: String? = nil
    @Published var errorPassword: String? = nil
    @Published var errorConfirmPassword: String? = nil
    @Published var errorMessage: String? = nil
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    func register() {
        let isNameEmpty = isFieldEmpty(name)
        let isEmailEmpty = isFieldEmpty(email)
        let isPasswordEmpty = isFieldEmpty(password)
        let isConfirmPasswordEmpty = isFieldEmpty(confirmPassword)
        let isNameValid = isValidName(name)
        let isEmailValid = isValidEmail(email)
        let isPasswordValid = isValidPassword(password)
        let isConfirmPasswordValid = isValidConfirmPassword(confirmPassword)
        
        if isEmailEmpty {
            errorEmail = "Invalid email. Please enter a valid email."
        }
        else if !isEmailValid {
            errorEmail = "Invalid email. Please enter a valid email."
        } else {
            errorEmail = nil
        }
        
        if isNameEmpty {
            errorName = "Name field required."
        }
        else if !isNameValid {
            errorName = "Name must not contain more than 60 characters."
        } else {
            errorName = nil
        }
        
        if isPasswordEmpty {
            errorPassword = "Password field required."
        }
        else if !isPasswordValid {
            errorPassword = "Invalid password. Password must be at least 6 characters long."
        } else {
            errorPassword = nil
        }
        
        if isConfirmPasswordEmpty {
            errorConfirmPassword = "Confirm Password field required."
        }
        else if !isConfirmPasswordValid {
            errorConfirmPassword = "Password does not match."
        } else {
            errorConfirmPassword = nil
        }
        
        RegisterApiService.register(name: name, email: email, password: password) { result in
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
    
    private func isValidName(_ name: String) -> Bool {
        return name.count <= 25
    }
    
    private func isFieldEmpty(_ fieldName: String) -> Bool {
        return fieldName.isEmpty
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {

        return password.count >= 6
    }
    
    private func isValidConfirmPassword(_ password: String) -> Bool {
        return password == self.password
    }
}
