//
//  Chart.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-22.
//

import Foundation

struct SpentAmountForPreviousSevenDays: Identifiable {
    let id: UUID
    let amount: Double
    let monthOrYear: String
    let daysCount: Int
    let budgetType: BudgetTypeOption
}
