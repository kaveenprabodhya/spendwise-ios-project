//
//  User.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var email: String
    var password: String
}
