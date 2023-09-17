//
//  BudgetViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-13.
//

import SwiftUI

class BudgetViewModel: ObservableObject{
        @Published var budgetArray:[Budget] =
    [
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .monthly, date: .monthOnly(9), limit: 2500),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Shopping",
                        primaryBackgroundColor: "ColorGoldenrod"
                    )
                ],
            allocatedAmount: 300000.00,
            currentAmountSpent: 100000.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .monthly, date: .monthOnly(8), limit: 2500),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Entertainment",
                        primaryBackgroundColor: "ColorGoldenrod"
                    )
                ],
            allocatedAmount: 100000.00,
            currentAmountSpent: 100.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .monthly, date: .monthOnly(9), limit: 2500),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Dining",
                        primaryBackgroundColor: "ColorGoldenrod"
                    )
                ],
            allocatedAmount: 300000.00,
            currentAmountSpent: 100000.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "Stay within your yearly budget!", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .yearly, date: .yearOnly(2023), limit: 8000),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Transportation",
                        primaryBackgroundColor: "ColorVividBlue"
                    )
                ],
            allocatedAmount: 546321.00,
            currentAmountSpent: 96532.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: false)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .yearly, date: .yearOnly(2023), limit: 8000),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Rent/Mortage",
                        primaryBackgroundColor: "ColorVividBlue"
                    )
                ],
            allocatedAmount: 52362.00,
            currentAmountSpent: 12283.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: false)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(10, 15, 22), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Groceries",
                        primaryBackgroundColor: "ColorSecondTealGreen"
                    )
                ],
            allocatedAmount: 785697.00,
            currentAmountSpent: 67480.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(10, 15, 22), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Vacation",
                        primaryBackgroundColor: "ColorSecondTealGreen"
                    )
                ],
            allocatedAmount: 458000.00,
            currentAmountSpent: 10000.00,
            numberOfDaysSpent: 12,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
    ]
    
    func fetchData() {
        ApiService.fetchBudgetData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let budgetItems):
                    self.budgetArray = budgetItems
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
