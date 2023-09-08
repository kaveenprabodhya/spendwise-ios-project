//
//  File.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import Foundation

struct BudgetCategory: Identifiable {
    let id: String
    let name: String
    let allocatedAmount: Double
    let currentAmountSpent: Double
}
