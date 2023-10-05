//
//  Income.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct BudgetTransaction: Identifiable {
    let id: UUID
    let category: TransactionCategory
    let transaction: Transaction
}

enum TransactionCategory: Codable {
    case income
    case expense
}

struct Transaction: Identifiable {
    let id: UUID
    let date: Date
    let budgetCategory: String
    let amount: Double
    let description: String
    let paymentMethod: String
    let location: String
    let attachment: Attachment
    let recurring: RecurringTransaction
}

struct RecurringTransaction {
    let frequency: String
    let date: String
}

struct Attachment {
    let type: String
    let url: URL
}
