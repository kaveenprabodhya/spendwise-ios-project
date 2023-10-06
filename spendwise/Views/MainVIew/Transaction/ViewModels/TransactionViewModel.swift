//
//  TransactionViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-29.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactionsArray: [BudgetTransaction] = [
        BudgetTransaction(
            id: UUID(),
            category: .expense,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .weekly,
                budgetCategory: "Shopping",
                amount: 19800,
                description: "Buy some cloths",
                paymentMethod: "Wallet",
                location: "RV",
                attachment: Attachment(type: "", url: URL(fileURLWithPath: "")),
                recurring: RecurringTransaction(frequency: "", date: ""))
        ),
        BudgetTransaction(
            id: UUID(),
            category: .income,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .monthly,
                budgetCategory: "Groceries",
                amount: 19800,
                description: "Buy some grocery",
                paymentMethod: "Wallet",
                location: "Supermarket",
                attachment: Attachment(type: "", url: URL(fileURLWithPath: "")),
                recurring: RecurringTransaction(frequency: "", date: ""))
        ),
        BudgetTransaction(
            id: UUID(),
            category: .income,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .yearly,
                budgetCategory: "Groceries",
                amount: 19800,
                description: "Buy some grocery",
                paymentMethod: "Wallet",
                location: "Supermarket",
                attachment: Attachment(type: "", url: URL(fileURLWithPath: "")),
                recurring: RecurringTransaction(frequency: "", date: ""))
        )
    ]
    
    var yearlyTransactions: [BudgetTransaction] {
        transactionsArray.filter { $0.transaction.budgetType == .yearly }
    }
    
    var monthlyTransactions: [BudgetTransaction] {
        transactionsArray.filter { $0.transaction.budgetType == .monthly }
    }
    
    var weeklyTransactions: [BudgetTransaction] {
        transactionsArray.filter { $0.transaction.budgetType == .weekly }
    }
    
    var transactionByMonth: [(String, [BudgetTransaction])] {
        let filteredTransactions = monthlyTransactions.filter { transaction in
            if case .monthly = transaction.transaction.budgetType {
                return true
            }
            return false
        }
        
        let groupedTransactions = Dictionary(grouping: filteredTransactions) { transaction -> String in
            if case .monthly = transaction.transaction.budgetType {
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "MMMM"
                return monthFormatter.string(from: transaction.transaction.date)
            }
            return ""
        }
        
        let result: [(String, [BudgetTransaction])] = groupedTransactions.map { (key, values) in
            return (key, values)
        }
        
        return result
    }
    
    var transactionByWeek: [(String, [BudgetTransaction])] {
        let filteredTransactions = weeklyTransactions.filter { transaction in
            if case .weekly = transaction.transaction.budgetType {
                return true
            }
            return false
        }
        
        let groupedTransactions = Dictionary(grouping: filteredTransactions) { transaction -> String in
            if case .weekly = transaction.transaction.budgetType {
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "MMMM"
                return monthFormatter.string(from: transaction.transaction.date)
            }
            return ""
        }
        
        let result: [(String, [BudgetTransaction])] = groupedTransactions.map { (key, values) in
            return (key, values)
        }
        
        return result
    }

    var transactionByYear: [(String, [BudgetTransaction])] {
        let filteredTransactions = yearlyTransactions.filter { transaction in
            if case .yearly = transaction.transaction.budgetType {
                return true
            }
            return false
        }
        
        let groupedTransactions = Dictionary(grouping: filteredTransactions) { transaction -> String in
            if case .yearly = transaction.transaction.budgetType {
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "yyyy"
                return yearFormatter.string(from: transaction.transaction.date)
            }
            return ""
        }
        
        let result: [(String, [BudgetTransaction])] = groupedTransactions.map { (key, values) in
            return (key, values)
        }
        
        return result
    }
    
    func printTransactionByYear(_ transactionsByYear: [(String, [BudgetTransaction])]) {
        for (year, transactions) in transactionsByYear {
            print("Year: \(year)")
            for transaction in transactions {
                print("Transaction ID: \(transaction.id)")
                print("Category: \(transaction.category)")
                // Print other transaction details as needed
            }
            print("------")
        }
    }
    
    func filterTransactions(by category: TransactionCategory) -> [BudgetTransaction] {
        return transactionsArray.filter { $0.category == category }
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
