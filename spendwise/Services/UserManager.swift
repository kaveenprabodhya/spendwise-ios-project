//
//  UserManager.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-04.
//

import Foundation

class UserManager {
    static var shared = UserManager()
    
    private init() { }
    
    func setUser(_ user: User?) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(user), forKey: "currentUser")
    }
    
    func getCurrentUser() -> User? {
        if let data = UserDefaults.standard.value(forKey: "currentUser") as? Data {
            return try? PropertyListDecoder().decode(User.self, from: data)
        }
        return nil
    }
}
