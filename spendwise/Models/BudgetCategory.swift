//
//  File.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct Budget: Identifiable {
    let id: String
    let category: [BudgetCategory]
    let allocatedAmount: Double
    let currentAmountSpent: Double
    let numberOfDaysSpent: Int
    let footerMessage: FooterMessage
}

struct FooterMessage {
    let message: String
    let warning: Bool
}

struct BudgetCategory: Identifiable {
    let id: String
    let name: String
    let primaryBackgroundColor: String
}
