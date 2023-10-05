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
                budgetCategory: "Groceries",
                amount: 19800,
                description: "Buy some grocery",
                paymentMethod: "Wallet",
                location: "Supermarket",
                attachment: Attachment(type: "", url: URL(fileURLWithPath: "")),
                recurring: RecurringTransaction(frequency: "", date: ""))
        )
    ]
    
    func filterTransactions(by category: TransactionCategory) -> [BudgetTransaction] {
        return transactionsArray.filter { $0.category == category }
    }
    
}
