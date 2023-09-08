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
