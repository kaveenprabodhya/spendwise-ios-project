//
//  User.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    var firstName: String
    var email: String
    var password: String
}
