//
//  IncomeDetailView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct TransactionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isSheetRemovePresented: Bool = false
    @State var isEditClicked: Bool = false
    @ObservedObject var transactionViewModel: TransactionViewModel = TransactionViewModel()
    var budgetTransaction: BudgetTransaction
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(gradientHeight: 240, sheetHeight: 647, gradientColors: [Color("ColorForestGreen"), Color("ColorTeal")], headerContent: {
                    VStack(alignment: .center) {
                        VStack(spacing: 0) {
                            Text("LKR \(formatCurrency(value: budgetTransaction.transaction.amount))")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.top, 20)
                                .padding(.bottom, 85)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }){
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("ColorBurgundy"))
                                .frame(width: 400, height: 82)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Text("Type")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("\(transactionViewModel.getTransactionType(type: budgetTransaction.type))")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Category")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("\(budgetTransaction.transaction.budgetCategory)")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Wallet")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundStyle(.white)
                                            Text("\(budgetTransaction.transaction.paymentMethod)")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundStyle(.white)
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                
                        }
                        .frame(height: 40)
                        .offset(y: -15)
                        .padding(.bottom, 10)
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [18, 5]))
                            .frame(height: 1)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                        VStack {
                            Text("\(formatDate(date: budgetTransaction.transaction.date))")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.black)
                                .padding(.vertical, 10)
                            Text("Description")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            Text("\(budgetTransaction.transaction.description)")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            Text("Attachment")
                                .foregroundStyle(.gray)
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                            if !budgetTransaction.transaction.attachment.name.isEmpty {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemGray4))
                                    .frame(width: 368, height: 248)
                                    .overlay {
                                        Image("\(budgetTransaction.transaction.attachment.name)")
                                            .resizable()
                                            .scaledToFit()
                                    }
                            } else {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemGray4))
                                    .frame(width: 368, height: 248)
                                    .overlay {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.white)
                                            .frame(width: 112 , height: 112)
                                    }
                            }
                            Spacer()
                            Button(action: {
                                isEditClicked = true
                            }, label: {})
                            .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Edit", cornerRadius: 16, iconName: "square.and.pencil"))
                            .navigationDestination(isPresented: $isEditClicked) {
                                NewTransactionView(budgetTransaction: budgetTransaction)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $isSheetRemovePresented, content: {
                SheetViewOfRemove(isSheetRemovePresented: $isSheetRemovePresented, action: {
                    if let currentUser = UserManager.shared.getCurrentUser() {
                        transactionViewModel.deleteTransaction(currentUser: currentUser, transactionId: budgetTransaction.id)
                        isSheetRemovePresented = false
                    }
                    isSheetRemovePresented = false
                })
            })
            .navigationDestination(isPresented: $transactionViewModel.onDeleteSuccess, destination: {
                ContentView(isVisibleAlert: true, alertType: .delete, index: 2)
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Detail Transaction")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.linear(duration: 0.25)) {
                            self.isSheetRemovePresented = true
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd - MMMM - yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let transaction = BudgetTransaction(id: UUID(), type: .expense, transaction: Transaction(id: UUID(), date: Date(), budgetType: .monthly, budgetCategory: "Shopping", amount: 2000, description: "blah", paymentMethod: "blahhhh", location: "sdsddd", attachment: Attachment(name: ""), recurring: RecurringTransaction(frequency: "", date: Date())))
        TransactionDetailView(budgetTransaction: transaction)
    }
}
