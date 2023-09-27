//
//  NewIncomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewTransactionView: View {
    var gradientColors: [Color]
    @Environment(\.dismiss) private var dismiss
    @State var inputAmount: String = ""
    @State var typeSelectedOption: String = ""
    @State var categorySelectedOption: String = ""
    @State var descriptionVal: String = ""
    @State var walletSecletedOption: String = ""
    @State var repeatTransaction: Bool = false
    @State var addAttachment: Bool = false
    @State var isSuccess: Bool = false
    @ObservedObject var budgetViewModel = BudgetViewModel()
    
    var body: some View {
        VStack{
            CustomContainerBodyView(
                gradientHeight: 240,
                sheetHeight: 667,
                gradientColors: gradientColors,
                headerContent: {
                    TransactionHeaderView(inputAmount: $inputAmount)
                }){
                    TransactionBodyView(typeSelectedOption: $typeSelectedOption, categorySelectedOption: $categorySelectedOption, descriptionVal: $descriptionVal, walletSecletedOption: $walletSecletedOption, repeatTransaction: $repeatTransaction, addAttachment: $addAttachment, budgetViewModel: budgetViewModel, isSuccess: $isSuccess)
                }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Income")
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
        }
    }
}

struct TransactionHeaderView: View {
    @Binding var inputAmount: String
    var body: some View {
        VStack {
            Text("How Much?")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Text("LKR")
                    .foregroundColor(.white)
                    .font(.system(size: 64, weight: .semibold))
                BottomLineTextFieldView(label: "", placeholder: "0.00", bottomLineColor: .white, placeholderColor: .white, textInputVal: $inputAmount)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TransactionBodyView: View {
    @Binding var typeSelectedOption: String
    @Binding var categorySelectedOption: String
    @Binding var descriptionVal: String
    @Binding var walletSecletedOption: String
    @Binding var repeatTransaction: Bool
    @Binding var addAttachment: Bool
    @ObservedObject var budgetViewModel: BudgetViewModel
    @Binding var isSuccess: Bool

    var body: some View {
        VStack(spacing: 0) {
            SelectOptionView(label: "", selectedOption: $typeSelectedOption, sheetLabel: "Pick Trtansaction Type", placeholderString: "Select Transaction", options: ["Expense", "Income"], placeholderStringFontSize: 20)
            
            SelectOptionView(label: "", selectedOption: $categorySelectedOption, sheetLabel: "Pick your Category", placeholderString: "Select Category", options: budgetViewModel.budgetCategoryArray, placeholderStringFontSize: 20)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
                .frame(height: 65)
                .overlay {
                    BottomLineTextFieldView(label: "", placeholder: "Description", placeholderFontSize: 20, textInputVal: $descriptionVal)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            SelectOptionView(label: "", selectedOption: $walletSecletedOption, sheetLabel: "Pick your Wallet Type", placeholderString: "Select Wallet", options: ["Cash", "Paypal", "Apple"], placeholderStringFontSize: 20)
            
            Button(action: {
                self.addAttachment = true
            }, label: {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(height: 65)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        HStack {
                            Image(systemName: "paperclip")
                                .font(.system(size: 26, weight: .medium))
                            Text("Add attatchment")
                                .font(.system(size: 20, weight: .medium))
                        }
                    }
            })
            .padding(.vertical, 16)
                .padding(.horizontal, 15)
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 2)
                    .frame(height: 65)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        VStack(spacing :0) {
                            HStack(alignment: .center){
                                VStack(alignment: .leading) {
                                    Text("Repeat")
                                        .font(.system(size: 20, weight: .medium))
                                    Text("Repeat transaction")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                CustomToggleView(isOn: $repeatTransaction)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.top, 5)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(.vertical, 6)
                .padding(.horizontal, 15)
            Spacer()
            VStack(spacing: 0) {
                Button(action: {
                }, label: {
                }
                )
                .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Create", cornerRadius: 16))
                .navigationDestination(
                    isPresented: $isSuccess) {
                        EmptyView()
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            Spacer()
        }
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView(gradientColors: [Color("ColorForestGreen"), Color("ColorTeal")])
    }
}
