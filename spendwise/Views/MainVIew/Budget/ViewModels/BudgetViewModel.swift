//
//  BudgetViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-13.
//

import SwiftUI

class BudgetViewModel: ObservableObject {
    @Published var amountSpentForLast7Days: [SpentAmountForPreviousSevenDays] = []
    @Published var overview: BudgetOverViewForUser = BudgetOverViewForUser(id: UUID(), overallAmount: 0.00, overallSpentAmount: 0.00, overallExpenseAmount: 0.00, overallIncomeAmount: 0.00)
    @Published var budgetCategoryArray: [BudgetCategory]  =
    [
        BudgetCategory(
            id: UUID(),
            name: "Shopping",
            primaryBackgroundColor: "ColorShopping",
            iconName: "cart"
        ),
        BudgetCategory(
            id: UUID(),
            name: "Transportation",
            primaryBackgroundColor: "ColorTransportation",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Groceries",
            primaryBackgroundColor: "ColorGroceries",
            iconName: "basket"
        ),
        BudgetCategory(
            id: UUID(),
            name: "Dining Out",
            primaryBackgroundColor: "ColorDiningOut",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Rent/Mortgage",
            primaryBackgroundColor: "ColorRentAndMortgage",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Utilities",
            primaryBackgroundColor: "ColorUtilities",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Healthcare",
            primaryBackgroundColor: "ColorHealthcare",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Savings/Investments",
            primaryBackgroundColor: "ColorSavingsAndInvestments",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Clothing",
            primaryBackgroundColor: "ColorClothing",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Travel",
            primaryBackgroundColor: "ColorTravel",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Maintenance",
            primaryBackgroundColor: "ColorMaintenance",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Gifts/Donations",
            primaryBackgroundColor: "ColorGiftsAndDonations",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Subscriptions",
            primaryBackgroundColor: "ColorSubscriptions",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Miscellaneous",
            primaryBackgroundColor: "ColorMiscellaneous",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Taxes",
            primaryBackgroundColor: "ColorTaxes",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Entertainment",
            primaryBackgroundColor: "ColorEntertainment",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Debt Repayment",
            primaryBackgroundColor: "ColorDebtRepayment",
            iconName: ""
        ),
        BudgetCategory(
            id: UUID(),
            name: "Education",
            primaryBackgroundColor: "ColorEducation",
            iconName: ""
        )
    ]
    @Published var budgetArray:[Budget] =
    [
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .monthly, date: .monthOnly(11), limit: 2500),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Shopping",
                        primaryBackgroundColor: "ColorGoldenrod", iconName: "cart"
                    )
                ],
            allocatedAmount: 300000.00,
            currentAmountSpent: 100000.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "Cool! let's keep your expense below the budget", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .monthly, date: .monthOnly(9), limit: 2500),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Shopping",
                        primaryBackgroundColor: "ColorGoldenrod", iconName: "cart"
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
                        primaryBackgroundColor: "ColorGoldenrod", iconName: ""
                    )
                ],
            allocatedAmount: 100000.00,
            currentAmountSpent: 10600.00,
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
                        primaryBackgroundColor: "ColorGoldenrod", iconName: ""
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
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
                    )
                ],
            allocatedAmount: 546321.00,
            currentAmountSpent: 96532.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: false)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .yearly, date: .yearOnly(2025), limit: 8000),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Transportation",
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
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
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
                    )
                ],
            allocatedAmount: 52362.00,
            currentAmountSpent: 12283.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: false)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .yearly, date: .yearOnly(2024), limit: 8000),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Rent/Mortage",
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
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
                        primaryBackgroundColor: "ColorSecondTealGreen", iconName: ""
                    )
                ],
            allocatedAmount: 785697.00,
            currentAmountSpent: 67480.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(10, 23, 27), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Rent",
                        primaryBackgroundColor: "ColorLavenderPurple", iconName: ""
                    )
                ],
            allocatedAmount: 785697.00,
            currentAmountSpent: 67480.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(10, 1, 7), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Vacation",
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
                    )
                ],
            allocatedAmount: 785697.00,
            currentAmountSpent: 67480.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(9, 1, 7), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Groceries",
                        primaryBackgroundColor: "ColorSecondTealGreen", iconName: ""
                    )
                ],
            allocatedAmount: 785697.00,
            currentAmountSpent: 67480.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(5, 15, 22), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Vacation",
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
                    )
                ],
            allocatedAmount: 458000.00,
            currentAmountSpent: 10000.00,
            numberOfDaysSpent: 12,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
        Budget(
            id: UUID(),
            budgetType: BudgetType(type: .weekly, date: .dateRange(7, 15, 22), limit: 1200),
            category:
                [
                    BudgetCategory(
                        id: UUID(),
                        name: "Vacation",
                        primaryBackgroundColor: "ColorVividBlue", iconName: ""
                    )
                ],
            allocatedAmount: 458000.00,
            currentAmountSpent: 10000.00,
            numberOfDaysSpent: 12,
            footerMessage: FooterMessage(message: "You are doing really great! ", warning: true)
        ),
    ]
    
    var yearlyBudgets: [Budget] {
        budgetArray.filter { $0.budgetType.type == .yearly }
    }
    
    var monthlyBudgets: [Budget] {
        budgetArray.filter { $0.budgetType.type == .monthly }
    }
    
    var weeklyBudgets: [Budget] {
        budgetArray.filter { $0.budgetType.type == .weekly }
    }
    
    var allocatedTotalBudgetAmountByMonth: [String: [String: Double]] {
        var totalAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allBudgets {
            for (month, budgets) in data {
                var monthData: [String: Double] = totalAmounts[type] ?? [:]
                let totalAmount = budgets.reduce(0) { result, budget in
                    result + budget.allocatedAmount
                }
                monthData[month] = totalAmount
                totalAmounts[type] = monthData
            }
        }
        
        return totalAmounts
    }
    
    var totalAmountSpentByMonth: [String: [String: Double]] {
        var totalAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allBudgets {
            for (month, budgets) in data {
                var monthData: [String: Double] = totalAmounts[type] ?? [:]
                let totalAmount = budgets.reduce(0) { result, budget in
                    result + budget.currentAmountSpent
                }
                monthData[month] = totalAmount
                totalAmounts[type] = monthData
            }
        }
        
        return totalAmounts
    }
    
    var totalAmountRemainingByMonth: [String: [String: Double]] {
        let allocatedTotalAmounts = allocatedTotalBudgetAmountByMonth
        let totalAmountsSpent = totalAmountSpentByMonth
        
        var remainingAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allocatedTotalAmounts {
            var monthData: [String: Double] = [:]
            for (month, allocatedAmount) in data {
                if let spentAmount = totalAmountsSpent[type]?[month] {
                    monthData[month] = allocatedAmount - spentAmount
                } else {
                    monthData[month] = allocatedAmount
                }
            }
            remainingAmounts[type] = monthData
        }
        
        return remainingAmounts
    }
    
    var progressValueByMonth: [String: [String: Float]] {
        let totalBudgets = allocatedTotalBudgetAmountByMonth
        let spentAmounts = totalAmountSpentByMonth
        
        var progressValues: [String: [String: Float]] = [:]
        
        for (type, data) in totalBudgets {
            var monthlyProgressData: [String: Float] = [:]
            for (month, totalBudget) in data {
                if let spentAmount = spentAmounts[type]?[month] {
                    let totalBudgetFloat = Float(totalBudget)
                    let spentAmountFloat = Float(spentAmount)
                    if totalBudgetFloat == 0 {
                        monthlyProgressData[month] = 0
                    } else {
                        let progress = spentAmountFloat / totalBudgetFloat
                        monthlyProgressData[month] = min(1.0, max(0.0, progress))
                    }
                } else {
                    monthlyProgressData[month] = 0
                }
            }
            progressValues[type] = monthlyProgressData
        }
        
        return progressValues
    }
    
    // type - month - budget
    var budgetByMonth:  [(String, [(String, [Budget])])]{
        let monthlyBudgets = monthlyBudgets.filter { budget in
            if case .monthOnly = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: monthlyBudgets) { budget -> String in
            if case .monthOnly(let month) = budget.budgetType.date {
                return DateFormatter().monthSymbols[month - 1]
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("monthly", [(key, values)])
        }
        return result
    }
    //type - range - budget
    var budgetByWeek:  [(String, [(String, [Budget])])] {
        let weeklyBudgets = weeklyBudgets.filter { budget in
            if case .dateRange = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: weeklyBudgets) { budget -> String in
            if case .dateRange(let month, let startDate, let endDate) = budget.budgetType.date {
                let monthName = DateFormatter().monthSymbols[month - 1]
                let weekDescription = "\(startDate)-\(endDate)"
                return "\(monthName), \(weekDescription)"
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("weekly", [(key, values)])
        }
        return result
    }
    //type - year - budget
    var budgetByYear:  [(String, [(String, [Budget])])] {
        let yearlyBudgets = yearlyBudgets.filter { budget in
            if case .yearOnly = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: yearlyBudgets) { budget -> String in
            if case .yearOnly(let year) = budget.budgetType.date {
                return String(year)
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("yearly", [(key, values)])
        }
        return result
    }
    
    var allBudgets: [(String, [(String, [Budget])])] {
        return budgetByMonth + budgetByWeek + budgetByYear
    }
    
    var limitForBudgetType: [String: [String: Double]] {
        var limits: [String: [String: Double]] = [:]
        
        for (budgetType, monthsAndBudgets) in allBudgets {
            for (month, budgets) in monthsAndBudgets {
                if let firstBudget = budgets.first {
                    let limit = firstBudget.budgetType.limit
                    
                    if limits[budgetType] == nil {
                        limits[budgetType] = [month: limit]
                    } else {
                        limits[budgetType]![month] = limit
                    }
                }
            }
        }
        
        return limits
    }
    
    var categoryColorDict: [String: String] {
        var result = [String: String]()
        
        for (_, weeklyBudgets) in budgetByWeek {
            for (_, budgetArray) in weeklyBudgets {
                for budget in budgetArray {
                    if let categoryName = budget.category.first?.name {
                        result["\(categoryName)"] = budget.category.first?.primaryBackgroundColor ?? ""
                    }
                }
            }
        }
        return result
    }
    
    //month - [category: dateRange]
    var dateRangesByMonth: [String: [[String: String]]] {
        var result = [String: [[String: String]]]()
        
        for (_, weeklyValues) in budgetByWeek {
            for (monthAndWeek, budget) in weeklyValues {
                let components = monthAndWeek.components(separatedBy: ", ")
                if components.count == 2 {
                    let month = components[0]
                    let weekDescription = components[1]
                    
                    if let categoryName = budget.first?.category.first?.name {
                        if var monthArray = result[month] {
                            // Create a new dictionary for the budget category and dateRange
                            let budgetDict = [categoryName: weekDescription]
                            
                            // Append the new dictionary to the existing month's array
                            monthArray.append(budgetDict)
                            
                            // Update the month in the result dictionary
                            result[month] = monthArray
                        } else {
                            // Create a new array for the month if it doesn't exist
                            let monthArray = [[categoryName: weekDescription]]
                            result[month] = monthArray
                        }
                    }
                }
            }
        }
        return result
    }
    
    func extractMonth(from inputString: String, with pattern: String) -> String? {
        if let range = inputString.range(of: pattern, options: .regularExpression) {
            var month = inputString[range]
            month.removeLast()
            return String(month)
        } else {
            return nil
        }
    }
    
    func getDateOptionAndLabel(selectedTab: BudgetTypeOption , for month: String, budgets: [(String, [(String, [Budget])])]) -> (BudgetDateOption, String)? {
        if selectedTab == .monthly || selectedTab == .yearly {
            for (_, data) in budgets {
                for (date, budgets) in data {
                    if date == month {
                        if let budget = budgets.first {
                            switch budget.budgetType.date {
                            case .monthOnly(let month):
                                let label = Calendar.current.monthSymbols[month - 1]
                                return (.monthOnly(month), label)
                            case .yearOnly(let year):
                                let label = "\(year)"
                                return (.yearOnly(year), label)
                            case .dateRange(let month, let startDate, let endDate):
                                let monthString = Calendar.current.monthSymbols[month - 1]
                                let label = "\(monthString), \(startDate)-\(endDate)"
                                return (.dateRange(month, startDate, endDate), label)
                            }
                        }
                    }
                }
            }
        }
        if selectedTab == .weekly {
            for (_, data) in budgets {
                for (date, budgets) in data {
                    if let monthExtracted = extractMonth(from: date, with: "([A-Za-z]+),") {
                        if monthExtracted == month {
                            if let budget = budgets.first {
                                switch budget.budgetType.date {
                                case .monthOnly(let month):
                                    let label = Calendar.current.monthSymbols[month - 1]
                                    return (.monthOnly(month), label)
                                case .yearOnly(let year):
                                    let label = "\(year)"
                                    return (.yearOnly(year), label)
                                case .dateRange(let month, let startDate, let endDate):
                                    let monthString = Calendar.current.monthSymbols[month - 1]
                                    let label = "\(monthString), \(startDate)-\(endDate)"
                                    return (.dateRange(month, startDate, endDate), label)
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func extractDateRange(from inputString: String) -> [Int]? {
        let regexPattern = #"\b(\d{1,2}-\d{1,2})\b"#
        if let range = inputString.range(of: regexPattern, options: .regularExpression) {
            let extractedRange = inputString[range]
            let components = extractedRange.components(separatedBy: "-")
            if components.count == 2, let start = Int(components[0]), let end = Int(components[1]) {
                return [start, end]
            }
        }
        
        return nil
    }
    
    
    func fetchBudgetData() {
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
    
    func fetchAmountSpentForLast7Days() {
        ApiService.fetchAmountSpentForLast7Days { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let amount):
                    self.amountSpentForLast7Days = amount
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    func fetchOverallBudgetForUser(currentUser: User) {
        ApiService.fetchOverallBudgetForUser(currentUser: currentUser) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let overview):
                    self.overview = overview
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
