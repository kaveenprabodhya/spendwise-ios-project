//
//  File.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct Budget: Identifiable, Codable {
    let id: UUID
    let name: String
    let budgetType: BudgetType
    let category: BudgetCategory
    let allocatedAmount: Double
    let currentAmountSpent: Double
    let numberOfDaysSpent: Int
    let footerMessage: FooterMessage
    let transactions: [BudgetTransaction]
}

struct FooterMessage: Codable {
    let message: String
    let warning: Bool
}

struct BudgetCategory: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let primaryBackgroundColor: String
    let iconName: String
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
    
    func stringValue() -> String? {
            switch self {
            case .yearOnly(let year):
                return "\(year)"
            case .monthOnly(let month):
                guard let monthName = DateFormatter().monthSymbols[safe: month - 1] else {
                    return nil // Invalid month number
                }
                return monthName
            case .dateRange(let month, let start, let end):
                guard let monthName = DateFormatter().monthSymbols[safe: month - 1] else {
                    return nil // Invalid month number
                }
                return "\(monthName), \(start)-\(end)"
            }
        }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

struct BudgetOverViewForUser: Identifiable, Codable {
    let id: UUID
    let overallAmount: Double
    let overallSpentAmount: Double
    let overallExpenseAmount: Double
    let overallIncomeAmount: Double
}
