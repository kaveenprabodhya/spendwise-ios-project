//
//  DetailBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct DetailBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isSheetRemovePresented: Bool = false
    @State private var capsuleWidth: CGFloat = 0
    @State private var categoryNameWidth: CGFloat = 0
    
    var budget:Budget = Budget(id: UUID(), budgetType: BudgetType(type: .monthly, date: .monthOnly(9), limit: 300), category: [BudgetCategory(id: UUID(), name: "Shopping", primaryBackgroundColor: "ColorVividBlue")], allocatedAmount: 300000000, currentAmountSpent: 3000000000, numberOfDaysSpent: 2, footerMessage: FooterMessage(message: "Cool! let's keep your expense below the budget", warning: false))
    
    func getTextWidth(text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font]
        let textSize = (text as NSString).size(withAttributes: attributes)
        return ceil(textSize.width)
    }
    
    var body: some View {
        NavigationStack {
        ZStack{
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")], headerContent: {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom , spacing: 0) {
                            Text("Monthly Budget")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                            Spacer()
                            Text("\(formatCurrency(value: budget.allocatedAmount))")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        VStack {
                            Text("You’ve spent")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            Capsule()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(width: capsuleWidth, height: 30)
                                .overlay{
                                    Text("LKR \(formatCurrency(value: budget.currentAmountSpent))")
                                        .foregroundColor(Color("ColorVividBlue"))
                                        .font(.system(size: 16, weight: .semibold))
                                        .onAppear{
                                            let textWidth = getTextWidth(text: "LKR \(formatCurrency(value: budget.currentAmountSpent))")
                                            capsuleWidth = textWidth + 10
                                        }
                                }
                            Text("for the past \(budget.numberOfDaysSpent) days")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                        .padding(.bottom, 8)
                        Spacer()
                    }
                }
                .padding()
            }) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Edit your Budget")
                            .font(.system(size: 22, weight: .medium))
                        Spacer()
                        Button {
                            
                        } label: {
                            Circle()
                                .fill(Color("ColorSilverGray"))
                                .frame(width: 36, height: 36)
                                .overlay {
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.white)
                                        .font(.system(size: 22))
                                }
                        }

                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10)
                    HStack {
                        Text("What’s left to spend")
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Text("LKR \(formatCurrency(value: 170001))")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(20)
                    
                    BudgetSpendingCardView(budget: budget)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.secondary)
                            .frame(width: categoryNameWidth, height: 64)
                            .overlay {
                                HStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.yellow)
                                        .frame(width: 50, height: 50)
                                        .overlay {
                                            Image(systemName: "cart")
                                                .font(.system(size: 28))
                                                .foregroundStyle(.white)
                                                .frame(width: 30)
                                        }
                                    let textWidth = getTextWidth(text: "Shopping")
                                    Text("Shopping")
                                        .font(.system(size: 22, weight: .semibold))
                                        .onAppear {
                                            categoryNameWidth = textWidth + 100
                                        }
                                }
                            }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 0) {
                        Text("Budget Transactions")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay {
                                ScrollView {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.white)
                                        .frame(height: 63)
                                        .shadow(color: .secondary, radius: 0, x: 5, y: 5)
                                        .overlay {
                                            VStack(spacing: 0) {
                                                BudgetTransactionListView()
                                            }
                                        }
                                        .padding(10)
                                }
                            }
                    }
                    
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $isSheetRemovePresented, content: {
            SheetViewOfRemove(isSheetRemovePresented: $isSheetRemovePresented)
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Detail Budget")
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
}

struct SheetViewOfRemove: View {
    @Binding var isSheetRemovePresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Remove")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.bottom, 20)
            Text("Are you sure do you wanna remove this budget?")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 250)
                .padding(.bottom, 30)
            HStack {
                Button {
                    
                } label: {
                }
                .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 164, height: 56, label: "Yes", cornerRadius: 16))
                
                Button {
                    withAnimation(.linear(duration: 0.25)) {
                        self.isSheetRemovePresented = false
                    }
                } label: {
                }
                .buttonStyle(CustomButtonStyle(fillColor: "ColorSilverGray", width: 164, height: 56, label: "No", cornerRadius: 16))
                
            }
            Spacer()
        }
        .presentationDetents([.height(261)])
        .presentationDragIndicator(.visible)
        .presentationBackground(.orange)
        .presentationCornerRadius(25)
    }
}

struct BudgetTransactionListView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("ColorVibrantJade"))
            .frame(height: 63)
            .overlay{
                HStack {
                    VStack(spacing: 0) {
                        Text("Expense")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("12/12/2021")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("+ \(formatCurrency(value: 150000))")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(10)
            }
    }
}

struct BudgetSpendingCardView: View {
    var budget: Budget
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color("ColorOliveMist"))
            .frame(width: 395, height: 168)
            .overlay {
                VStack(spacing: 0) {
                    HStack {
                        Text("You’ve already spent")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Text("Spend Limit per Day")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }.padding(.bottom, 10)
                    HStack {
                        Text("LKR \(formatCurrency(value: 10000000))")
                            .foregroundColor(Color("ColorDarkBlue"))
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                        Text("LKR \(formatCurrency(value: 12501549))")
                            .foregroundStyle(Color("ColorDarkBlue"))
                            .font(.system(size: 18, weight: .semibold))
                    }.padding(.bottom, 10)
                    VStack {
                        GeometryReader { geometry in
                            ProgressView(value: calculateProgressBarValue(amountAllocated: budget.allocatedAmount, spent: budget.currentAmountSpent), total: 100)
                                .progressViewStyle(RoundedRectProgressViewStyle(color: Color("ColorJadeGreen"), width: geometry.size.width))
                                .accentColor(Color("ColorFreshMintGreen"))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 5, height: 18)
                                        .foregroundStyle(Color("ColorDarkMaroon"))
                                        .offset(x: 90)
                                }
                        }.padding(.bottom, 10)
                    }
                    HStack {
                        if(budget.footerMessage.warning){
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                            Text(budget.footerMessage.message)
                                .font(.system(size: 18, weight: .bold))
                                .lineLimit(nil)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }else {
                            Text(budget.footerMessage.message)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(nil)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .padding(20)
            }
    }
    
    private func calculateProgressBarValue(amountAllocated: Double, spent: Double) -> Double {
        guard amountAllocated > 0 else {
            return 0.0
        }
        let progress = (spent / amountAllocated) * 100.0
        return min(max(progress, 0.0), 100.0)
    }
    
    private func calculateRemainingAmount(amountAllocated: Double, spent: Double) -> Double {
        let remainingAmount = amountAllocated - spent
        return max(remainingAmount, 0.0)
    }
}

struct DetailBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBudgetView()
    }
}
