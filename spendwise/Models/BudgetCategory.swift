//
//  File.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct Budget: Identifiable {
    let id: UUID
    let budgetType: BudgetType
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

struct BudgetCategory: Identifiable, Hashable {
    let id: UUID
    let name: String
    let primaryBackgroundColor: String
}

struct BudgetType {
    let type: BudgetTypeOption
    let date: BudgetDateOption
    let limit: Double
}

enum BudgetTypeOption: String {
    case monthly = "monthly"
    case weekly = "weekly"
    case yearly = "yearly"
}

enum BudgetDateOption {
    case yearOnly(Int)
    case monthOnly(Int)
    // month, start-date, end-date
    case dateRange(Int, Int, Int)
}
