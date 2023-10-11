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
    @Published var pickdate: String = "\(Calendar.current.component(.day, from: Date()).description + " - " + Calendar.current.monthSymbols[Calendar.current.component(.month, from: Date()) - 1] + " - " + Calendar.current.component(.year, from: Date()).description)"
    @Published var selectedDate2 = Date()
    @Published var selectedDate = Date()
    @Published var endAfter: String = ""
    @Published var locationVal: String = ""
    @Published var avatarImage: Image?
    @Published var avatarItem: PhotosPickerItem?
    @Published var repeatTransaction: Bool = false
    @Published var addAttachment: Bool = false
    @Published var isRepeatTransactionSuccess: Bool = false
    @Published var isAddAttachmentSuccess: Bool = false
    
    @Published var errorInputAmount: String? = nil
    @Published var errorType: Bool = false
    @Published var errorCategory: Bool = false
    @Published var errorBudgetType: Bool = false
    @Published var errorDate: Bool = false
    @Published var errorDescription: Bool = false
    @Published var errorWallet: Bool = false
    @Published var errorLocation: Bool = false
    @Published var errorFrequency: String? = nil
    @Published var errorEndAfter: Bool = false
    
    @Published var onSubmitSuccess: Bool = false
    @Published var onDeleteSuccess: Bool = false
    @Published var onUpdateSuccess: Bool = false
    @Published var onFailure: Bool = false
    
    @Published var transactionArray: [BudgetTransaction] = [
        BudgetTransaction(
            id: UUID(),
            type: .expense,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .weekly,
                budgetCategory: "Shopping",
                amount: 19800,
                description: "Buy some cloths",
                paymentMethod: "Wallet",
                location: "RV",
                attachment: Attachment(name: ""),
                recurring: RecurringTransaction(frequency: "", date: Date())), userId: UUID()
        ),
        BudgetTransaction(
            id: UUID(),
            type: .income,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .monthly,
                budgetCategory: "Groceries",
                amount: 19800,
                description: "Buy some grocery",
                paymentMethod: "Wallet",
                location: "Supermarket",
                attachment: Attachment(name: ""),
                recurring: RecurringTransaction(frequency: "", date: Date())), userId: UUID()
        ),
        BudgetTransaction(
            id: UUID(),
            type: .income,
            transaction: Transaction(
                id: UUID(),
                date: Date.now,
                budgetType: .yearly,
                budgetCategory: "Groceries",
                amount: 19800,
                description: "Buy some grocery",
                paymentMethod: "Wallet",
                location: "Supermarket",
                attachment: Attachment(name: ""),
                recurring: RecurringTransaction(frequency: "", date: Date())), userId: UUID()
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
                print("Category: \(transaction.type)")
                // Print other transaction details as needed
            }
            print("------")
        }
    }
    
    func filterTransactions(by category: TransactionCategory) -> [BudgetTransaction] {
        return transactionArray.filter { $0.type == category }
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func fetchAllTransactionData(currentUser: User) {
        TransactionApiService.fetchAllTransactionDataForUser(currentUser: currentUser) { result in
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
    
    func validateIsEmpty() -> Bool {
        let amount = isFieldEmpty(inputAmount)
        let type = isFieldEmpty(typeSelectedOption)
        let category = isFieldEmpty(categorySelectedOption)
        let date = isFieldEmpty(pickdate)
        let budgetType = isFieldEmpty(budgetTypeSelectedOption)
        let description = isFieldEmpty(descriptionVal)
        let wallet = isFieldEmpty(walletSecletedOption)
        let location = isFieldEmpty(locationVal)
        
        if amount {
            errorInputAmount = "Amount is required."
        }
        else if !validateNumberFormat() {
            errorInputAmount = "Invalid Amount"
        }
        else {
            errorInputAmount = nil
        }
        
        if type {
            errorType = true
        }
        else {
            errorType = false
        }
        
        if typeSelectedOption.localizedCaseInsensitiveContains("expense")
        {
            if category {
                errorCategory = true
            }
            else {
                errorCategory = false
            }
        }
        
        if budgetType {
            errorBudgetType = true
        }
        else {
            errorBudgetType = false
        }
        
        if date {
            errorDate = true
        }
        else {
            errorDate = false
        }
        
        if  description {
            errorDescription = true
        }
        else {
            errorDescription = false
        }
        
        if typeSelectedOption.localizedCaseInsensitiveContains("expense")
        {
            if  location {
                errorLocation = true
            }
            else {
                errorLocation = false
            }
        }
        
        if typeSelectedOption.localizedCaseInsensitiveContains("expense")
        {
            if wallet {
                errorWallet = true
            }
            else {
                errorWallet = false
            }
        }
        
        if amount || !validateNumberFormat() || budgetType || date || description {
            return false
        }
        
        if typeSelectedOption.localizedCaseInsensitiveContains("expense")
        {
            if wallet || category || location {
                return false
            }
        }
        
        return true
    }
    
    func validateNumberFormat() -> Bool {
        return Double(inputAmount) != nil
    }
    
    func validateRepeat() -> Bool {
        let frequency = isFieldEmpty(frequencySelectedOption)
        
        if frequency {
            errorFrequency = "Type is required."
            return false
        }
        else {
            errorFrequency = nil
        }
        return true
    }
    
    func getBudgetTypeOption(rawValue: String) -> BudgetTypeOption? {
        switch rawValue {
        case "Monthly":
            return .monthly
        case "Yearly":
            return .yearly
        case "Weekly":
            return .weekly
        default:
            return nil
        }
    }
    
    func getBudgetType(type: BudgetTypeOption) -> String {
        switch type {
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        case .weekly:
            return "Weekly"
        }
    }
    
    func getTransactionType(type: TransactionCategory) -> String {
        switch type {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd - MMMM - yyyy"
        return dateFormatter.string(from: date)
    }
    
    func submit(currentUser: User) {
        let validationResult = validateIsEmpty()
        if !validationResult {
            return
        }
        print("\(self.pickdate)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datePick = dateFormatter.date(from: self.pickdate)
        
        print("\(self.pickdate) - \(String(describing: datePick))")

        if let budgetType = getBudgetTypeOption(rawValue: self.budgetTypeSelectedOption) {
            if let date = datePick {
                if let amount = Double(self.inputAmount) {
                    if let endAfter = dateFormatter.date(from: self.endAfter) {
                        let transaction = BudgetTransaction(
                            id: UUID(),
                            type: (self.typeSelectedOption == "income") ? .income : .expense,
                            transaction: Transaction(
                                id: UUID(),
                                date: date,
                                budgetType: budgetType,
                                budgetCategory: self.categorySelectedOption,
                                amount: amount,
                                description: self.descriptionVal,
                                paymentMethod: self.walletSecletedOption,
                                location: self.locationVal,
                                attachment: Attachment(name: ""),
                                recurring: RecurringTransaction(
                                    frequency: self.frequencySelectedOption,
                                    date: endAfter
                                )
                            ), userId: currentUser.id
                        )
                    TransactionApiService.createTransaction(currentUser: currentUser, transaction: transaction) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let createdTransaction):
                                self.onSubmitSuccess = true
                                self.transactionArray.append(createdTransaction)
                            case .failure(let error):
                                print("Error fetching data: \(error)")
                                self.onFailure = true
                            }
                        }
                    }
                }
                } else {
                    print("double cast error")
                }
            } else {
                print("date pick error")
            }
        } else {
            print("budget type error")
        }
    }
    
    func deleteTransaction(currentUser: User, transactionId: UUID) {
        TransactionApiService.deleteTransaction(currentUser: currentUser, transactionId: transactionId){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    if let index = self.transactionArray.firstIndex(where: { $0.id == transactionId }) {
                        // Remove the transaction object from the transactions array
                        self.transactionArray.remove(at: index)
                    }
                    self.onDeleteSuccess = true
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    self.onFailure = true
                }
            }
        }
    }
    
    func update(currentUser: User, transactionId: UUID) {
        let validationResult = validateIsEmpty()
        if !validationResult {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datePick = dateFormatter.date(from: self.pickdate)
        if let budgetType = getBudgetTypeOption(rawValue: self.budgetTypeSelectedOption) {
            if let date = datePick {
                if let amount = Double(self.inputAmount) {
                    if let endAfter = dateFormatter.date(from: self.endAfter) {
                        let transaction = BudgetTransaction(
                            id: UUID(),
                            type: (self.typeSelectedOption == "income") ? .income : .expense,
                            transaction: Transaction(
                                id: transactionId,
                                date: date,
                                budgetType: budgetType,
                                budgetCategory: self.categorySelectedOption,
                                amount: amount,
                                description: self.descriptionVal,
                                paymentMethod: self.walletSecletedOption,
                                location: self.locationVal,
                                attachment: Attachment(name: ""),
                                recurring: RecurringTransaction(
                                    frequency: self.frequencySelectedOption,
                                    date: endAfter
                                )
                            ), userId: currentUser.id
                        )
                        TransactionApiService.updateTransaction(currentUser: currentUser, transaction: transaction){ result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let updatedTransaction):
                                    if let index = self.transactionArray.firstIndex(where: { $0.id == updatedTransaction.id }) {
                                        // Replace the old transaction with the updated transaction in the transactions array
                                        self.transactionArray[index] = updatedTransaction
                                    }
                                    self.onUpdateSuccess = true
                                case .failure(let error):
                                    print("Error fetching data: \(error)")
                                    self.onFailure = true
                                }
                            }
                        }
                    }
                } else {
                    print("double cast error")
                }
            } else {
                print("date pick error")
            }
        } else {
            print("budget type error")
        }
    }
}
