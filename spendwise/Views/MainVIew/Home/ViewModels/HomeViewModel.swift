//
//  HomeViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-13.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var prevoiusMonthlyAverage: PreviousMonthSpentAmountRelatedToCurrentPeriod = PreviousMonthSpentAmountRelatedToCurrentPeriod(id: UUID(), amount: 0.00)
    @Published var ongoingWeekExpensesAndIncome: [OngoingWeekExpensesByDay]  = [
        OngoingWeekExpensesByDay(id: UUID(), type: .expense, amount: 0.0, shortDay: "monday"),
        OngoingWeekExpensesByDay(id: UUID(), type: .income, amount: 0.0, shortDay: "monday"),
        OngoingWeekExpensesByDay(id: UUID(), type: .expense, amount:0.0, shortDay: "wednesday"),
        OngoingWeekExpensesByDay(id: UUID(), type: .income, amount: 0.0, shortDay: "monday"),
        OngoingWeekExpensesByDay(id: UUID(), type: .income, amount: 0.0, shortDay: "monday"),
        OngoingWeekExpensesByDay(id: UUID(), type: .expense, amount: 0.0, shortDay: "thursday"),
    ]
    @Published var overview: BudgetOverViewForUser = BudgetOverViewForUser(id: UUID(), overallAmount: 0.00, overallSpentAmount: 0.00, overallExpenseAmount: 0.00, overallIncomeAmount: 0.00)
    
    var filteredExpensesByDay: [String: [[TransactionCategory: Double]]] {
        let filteredExpenses = ongoingWeekExpensesAndIncome.filter { expense in
            return (expense.type == .expense || expense.type == .income)
        }
        
        var groupedExpenses: [String: [[TransactionCategory: Double]]] = [:]
        
        for expense in filteredExpenses {
            let day = expense.shortDay
            let category = expense.type
            
            if var dayExpenses = groupedExpenses[day] {
                if let index = dayExpenses.firstIndex(where: { $0.keys.first == category }) {
                    dayExpenses[index][category]! += expense.amount
                } else {
                    dayExpenses.append([category: expense.amount])
                }
                groupedExpenses[day] = dayExpenses
            } else {
                groupedExpenses[day] = [[category: expense.amount]]
            }
        }
        
        return groupedExpenses
    }
    
    func fetchPrevoiusMonthlyAverage(currentUser: User) {
        ChartApiService.fetchPreviousMonthSpentAmountRelatedToCurrentPeriod(currentUser: currentUser) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let prevoiusMonthlyAverage):
                    self.prevoiusMonthlyAverage = prevoiusMonthlyAverage
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    func fetchOngoingWeekExpenseAndIncomeByDay(currentUser: User) {
        ChartApiService.fetchOngoingWeekExpenseAndIncomeByDay(currentUser: currentUser) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ongoingWeekExpensesAndIncome):
                    self.ongoingWeekExpensesAndIncome = ongoingWeekExpensesAndIncome
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    func fetchOverallBudgetForUser(currentUser: User) {
        BudgetApiService.fetchOverallBudgetForUser(currentUser: currentUser) { result in
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
