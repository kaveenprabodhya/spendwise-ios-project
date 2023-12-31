//
//  Income.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct BudgetTransaction: Identifiable, Codable {
    let id: UUID
    let type: TransactionCategory
    let transaction: Transaction
    let userId: UUID
}

enum TransactionCategory: Codable {
    case income
    case expense
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    let date: Date
    let budgetType: BudgetTypeOption
    let budgetCategory: String
    let amount: Double
    let description: String
    let paymentMethod: String
    let location: String
    let attachment: Attachment
    let recurring: RecurringTransaction
}

struct RecurringTransaction: Codable {
    let frequency: String
    let date: Date
}

struct Attachment: Codable {
    let name: String
}
