//
//  File.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct Budget: Identifiable, Codable {
    let id: UUID
    let budgetType: BudgetType
    let category: [BudgetCategory]
    let allocatedAmount: Double
    let currentAmountSpent: Double
    let numberOfDaysSpent: Int
    let footerMessage: FooterMessage
}

struct FooterMessage: Codable {
    let message: String
    let warning: Bool
}

struct BudgetCategory: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let primaryBackgroundColor: String
}

struct BudgetType: Codable {
    let type: BudgetTypeOption
    let date: BudgetDateOption
    let limit: Double
}

enum BudgetTypeOption: String, Codable {
    case monthly = "monthly"
    case weekly = "weekly"
    case yearly = "yearly"
}

enum BudgetDateOption: Codable {
    case yearOnly(Int)
    case monthOnly(Int)
    // month, start-date, end-date
    case dateRange(Int, Int, Int)
}

struct BudgetOverViewForUser: Identifiable, Codable {
    let id: UUID
    let overallAmount: Double
    let overallSpentAmount: Double
    let overallExpenseAmount: Double
    let overallIncomeAmount: Double
}
