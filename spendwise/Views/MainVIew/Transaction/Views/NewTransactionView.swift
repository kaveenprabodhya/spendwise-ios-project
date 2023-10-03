//
//  NewIncomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var inputAmount: String = ""
    @State var typeSelectedOption: String = ""
    @State var categorySelectedOption: String = ""
    @State var descriptionVal: String = ""
    @State var walletSecletedOption: String = ""
    @State var frequencySelectedOption: String = ""
    @State var endAfterSecletedOption: String = ""
    @State var repeatTransaction: Bool = false
    @State var addAttachment: Bool = false
    @State var isSuccess: Bool = false
    @State var selectedDate = Date()
    @ObservedObject var budgetViewModel = BudgetViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(
                    gradientHeight: 240,
                    sheetHeight: 637,
                    gradientColors: [Color("ColorAzureBlue")],
                    headerContent: {
                        TransactionHeaderView(inputAmount: $inputAmount)
                    }){
                        TransactionBodyView(typeSelectedOption: $typeSelectedOption, categorySelectedOption: $categorySelectedOption, descriptionVal: $descriptionVal, walletSecletedOption: $walletSecletedOption, repeatTransaction: $repeatTransaction, addAttachment: $addAttachment, budgetViewModel: budgetViewModel, isSuccess: $isSuccess, frequencySelectedOption: $frequencySelectedOption, selectedDate: $selectedDate)
                    }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Transaction")
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
                BottomLineTextFieldView(label: "", placeholder: "0.00", fontColor: .white, bottomLineColor: .white, placeholderColor: .white, textInputVal: $inputAmount)
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
    @State var isRepeatTransactionSuccess: Bool = false
    @State var isAddAttachmentSuccess: Bool = false
    @Binding var frequencySelectedOption: String
    @Binding var selectedDate: Date
    @State var endAfter: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            SelectOptionView(label: "", selectedOption: $typeSelectedOption, sheetLabel: "Pick Trtansaction Type", placeholderString: "Select Transaction", options: ["Expense", "Income"], placeholderStringFontSize: 20){}
                .padding(.top, 6)
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            SelectOptionView(label: "", selectedOption: $categorySelectedOption, sheetLabel: "Pick your Category", placeholderString: "Select Category", options: budgetViewModel.budgetCategoryArray, placeholderStringFontSize: 20){}
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
                .frame(height: 65)
                .overlay {
                    BottomLineTextFieldView(label: "", placeholder: "Description", fontColor: .black, textFieldFontSize: 20, placeholderFontSize: 20, textInputVal: $descriptionVal)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            SelectOptionView(label: "", selectedOption: $walletSecletedOption, sheetLabel: "Pick your Wallet Type", placeholderString: "Select Wallet", options: ["Cash", "Paypal", "Apple"], placeholderStringFontSize: 20){}
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            if !isAddAttachmentSuccess {
                Spacer()
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
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                Spacer()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("ColorAzureBlue"))
                        .frame(width: 112, height: 112)
                        .overlay {
                            Image("successful-alert")
                                .resizable()
                                .scaledToFit()
                        }
                    Circle()
                        .fill(.secondary)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Button(action: {
                                
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.white)
                            })
                        }
                        .offset(CGSize(width: 49.0, height: -45.0))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15).padding(.vertical, 8)
            }
            
            if !isRepeatTransactionSuccess {
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
            } else {
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Frequency").fontWeight(.medium)
                            Text("\(frequencySelectedOption)")
                        }.padding(.trailing, 15)
                        VStack {
                            Text("End After").fontWeight(.medium).frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(formatDate(date: selectedDate))")
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        VStack {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("ColorAzureBlue"))
                                    .frame(width: 59, height: 32)
                                    .overlay {
                                        Text("Edit")
                                            .foregroundStyle(.white)
                                    }
                            }
                            
                        }
                    }
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            Spacer()
            VStack(spacing: 0) {
                Button(action: {
                    
                }, label: {})
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
        .sheet(isPresented: $addAttachment) {
            VStack {
                HStack(spacing: 40) {
                    Button(action: {
                        isAddAttachmentSuccess = true
                        addAttachment = false
                    }, label: {
                        RoundedRectangle(cornerRadius: 16.0)
                            .fill(Color("ColorVividBlue"))
                            .frame(width: 107, height: 91)
                            .overlay {
                                VStack {
                                    Image(systemName: "camera")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                    Text("Camera")
                                        .font(.system(size: 22))
                                        .foregroundStyle(.white)
                                }
                            }
                    })
                    Button(action: {
                        isAddAttachmentSuccess = true
                        addAttachment = false
                    }, label: {
                        RoundedRectangle(cornerRadius: 16.0)
                            .fill(Color("ColorVividBlue"))
                            .frame(width: 107, height: 91)
                            .overlay {
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.white)
                                    Text("Image")
                                        .font(.system(size: 22))
                                        .foregroundStyle(.white)
                                }
                            }
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea(edges: .bottom)
            .presentationDetents([.height(200)])
            .presentationDragIndicator(.visible)
            .presentationBackground(.orange)
            .presentationCornerRadius(25)
        }
        .sheet(isPresented: $repeatTransaction) {
            VStack {
                SelectOptionView(label: "", selectedOption: $frequencySelectedOption, sheetLabel: "Pick your Frequency", placeholderString: "Frequency", options: ["Monthly", "Weekly", "Yearly"], iconColor: .white, placeholderStringColor: .white, placeholderStringFontSize: 20, strokeColor: .white){}
                    .padding(.vertical, 6)
                    .padding(.horizontal, 15)
                SelectOptionView<String, VStack>(label: "", selectedOption: $endAfter, sheetLabel: "Date", placeholderString: "End After", iconColor: .white, placeholderStringColor: .white, placeholderStringFontSize: 20, strokeColor: .white, content: {
                    VStack(spacing: 10) {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.wheel).border(.red).foregroundStyle(.white)
                            .onChange(of: selectedDate) { newDate in
                                endAfter = formatDate(date: newDate)
                            }
                            .onAppear {
                                endAfter = formatDate(date: Date())
                            }
                        
                        Spacer()
                        Text("\(formatDate(date: selectedDate))")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        HStack(alignment: .center) {
                            Image(systemName: "exclamationmark.circle")
                                .font(.system(size: 28))
                            Text("After selecting the date, close the sheet and continue process.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                })
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                Button(action: {
                    self.repeatTransaction = false
                    self.isRepeatTransactionSuccess = true
                }, label: {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("ColorVividBlue"))
                        .frame(height: 65)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            HStack {
                                Text("Continue")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                        }
                })
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .presentationDetents([.height(335)])
                .presentationDragIndicator(.visible)
                .presentationBackground(.orange)
                .presentationCornerRadius(25)
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.dateFormat = "dd - MMMM - yyyy"
        return dateFormatter.string(from: date)
    }
    
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
