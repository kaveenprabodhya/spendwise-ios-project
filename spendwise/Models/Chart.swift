//
//  Chart.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-22.
//

import Foundation

struct SpentAmountForPreviousSevenDays: Identifiable, Codable {
    let id: UUID
    let amount: Double
    let monthOrYear: String
    let daysCount: Int
    let budgetType: BudgetTypeOption
}

struct PreviousMonthSpentAmountRelatedToCurrentPeriod: Identifiable, Codable {
    let id: UUID
    let amount: Double
}

struct OngoingWeekExpensesByDay: Identifiable, Codable {
    let id: UUID
    let type: TransactionCategory
    let amount: Double
    let shortDay: String
}
