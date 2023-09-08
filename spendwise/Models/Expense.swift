//
//  Expense.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

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
