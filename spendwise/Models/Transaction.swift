//
//  Income.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct Income: Identifiable {
    let id: String
    let date: Date
    let amount: Double
    let source: String
    let description: String
    let recurring: RecurringIncome
}

struct RecurringIncome {
    let frequency: String
    let date: String
}

struct Expense: Identifiable {
    let id: String
    let date: Date
    let category: Category
    let amount: Double
    let description: String
    let paymentMethod: String
    let location: String
    let attachment: Attachment
    let recurring: RecurringExpense
}

struct RecurringExpense {
    let frequency: String
    let endDate: String
}

struct Attachment {
    let type: String
    let url: URL
}
