//
//  currencyFormatter.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-10.
//

import Foundation

func formatCurrency(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: value)) ?? ""
}
