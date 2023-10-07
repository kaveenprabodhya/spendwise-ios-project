//
//  TransactionViewModel.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-29.
//

import Foundation
import PhotosUI
import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var inputAmount: String = ""
    @Published var typeSelectedOption: String = ""
    @Published var categorySelectedOption: String = ""
    @Published var budgetTypeSelectedOption: String = ""
    @Published var descriptionVal: String = ""
    @Published var walletSecletedOption: String = ""
    @Published var frequencySelectedOption: String = ""
    @Published var endAfterSecletedOption: String = ""
    @Published var selectedDate = Date()
    @Published var selectedDate2 = Date()
    @Published var avatarImage: Image?
    @Published var avatarItem: PhotosPickerItem?
    @Published var repeatTransaction: Bool = false
    @Published var addAttachment: Bool = false
    @Published var isSuccess: Bool = false
    @Published var isRepeatTransactionSuccess: Bool = false
    @Published var isAddAttachmentSuccess: Bool = false
    @Published var endAfter: String = ""
    @Published var pickdate: String = ""
    @Published var errorInputAmount: String? = nil
    @Published var errorCategory: String? = nil
    @Published var errorBudgetType: String? = nil
    @Published var errorDescription: String? = nil
    @Published var errorWallet: String? = nil
    @Published var errorFrequency: String? = nil
    @Published var errorEndAfter: String? = nil
    @Published var transactionArray: [BudgetTransaction] = [
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
        transactionArray.filter { $0.transaction.budgetType == .yearly }
    }
    
    var monthlyTransactions: [BudgetTransaction] {
        transactionArray.filter { $0.transaction.budgetType == .monthly }
    }
    
    var weeklyTransactions: [BudgetTransaction] {
        transactionArray.filter { $0.transaction.budgetType == .weekly }
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
        return transactionArray.filter { $0.category == category }
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func fetchAllTransactionData() {
        TransactionApiService.fetchAllTransactionDataForUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transactionItems):
                    self.transactionArray = transactionItems
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
    
    private func isFieldEmpty(_ fieldName: String) -> Bool {
        return fieldName.isEmpty
    }
    
    func submit() {
        let amount = isFieldEmpty(inputAmount)
        let category = isFieldEmpty(categorySelectedOption)
        let budgetType = isFieldEmpty(budgetTypeSelectedOption)
        let description = isFieldEmpty(descriptionVal)
        let wallet = isFieldEmpty(walletSecletedOption)
        
        let emptyMessage = "Don't leave empty fields"
        if amount {
            errorInputAmount = emptyMessage
        }
        else {
            errorInputAmount = nil
        }
        if category {
            errorCategory = emptyMessage
        }
        else {
            errorCategory = nil
        }
        if budgetType {
            errorBudgetType = emptyMessage
        }
        else {
            errorBudgetType = nil
        }
        if  description {
            errorDescription = emptyMessage
        }
        else {
            errorDescription = nil
        }
        if wallet {
            errorWallet = emptyMessage
        }
        else {
            errorWallet = nil
        }
    }
}
