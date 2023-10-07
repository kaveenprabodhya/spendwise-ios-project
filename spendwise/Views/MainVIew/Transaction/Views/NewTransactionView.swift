//
//  NewIncomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI
import PhotosUI

struct NewTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var budgetViewModel: BudgetViewModel = BudgetViewModel()
    @ObservedObject var transactionViewModel:TransactionViewModel = TransactionViewModel()
    
    func getGradientForType(typeSelectedOption: String) -> [Color] {
        let lowercasedOption = typeSelectedOption.lowercased()
        switch lowercasedOption {
        case "expense":
            return [Color("ColorBrickRed"), Color("ColorDeepEspressoBrown")]
        case "income":
            return [Color("ColorForestGreen"), Color("ColorTeal")]
        default:
            return [Color("ColorAzureBlue")]
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                CustomContainerBodyView(
                    gradientHeight: 240,
                    sheetHeight: 637,
                    gradientColors: getGradientForType(typeSelectedOption: transactionViewModel.typeSelectedOption),
                    headerContent: {
                        TransactionHeaderView(inputAmount: $transactionViewModel.inputAmount)
                    }){
                        TransactionBodyView(
                            budgetViewModel: budgetViewModel,
                            transactionViewModel: transactionViewModel
                        )
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        transactionViewModel.submit()
                    } label: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("ColorDarkBlue"))
                            .frame(width: 78, height: 32)
                            .overlay {
                                HStack(alignment: .center) {
                                    Text("Create")
                                        .foregroundStyle(.white)
                                    .fontWeight(.medium)
                                }
                            }
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
            HStack(alignment: .bottom) {
                Text("LKR")
                    .foregroundColor(.white)
                    .font(.system(size: 64, weight: .semibold))
                BottomLineTextFieldView(label: "", placeholder: "0.00", fontColor: .white, bottomLineColor: .white, placeholderColor: .white, textInputVal: $inputAmount)
                    .padding(.vertical, 15)
            }
        }
        .padding()
        .padding(.top, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TransactionBodyView: View {
    @ObservedObject var budgetViewModel: BudgetViewModel
    @ObservedObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            let transactionOptions = ["Expense", "Income"]
            SelectOptionView(
                label: "",
                selectedOption: $transactionViewModel.typeSelectedOption,
                sheetLabel: "Pick Trtansaction Type",
                placeholderString: "Select Transaction",
                options: transactionOptions,
                placeholderStringFontSize: 20,
                height: 54,
                sheetHeight: transactionOptions.count > 3 ? nil : 281
            ){}
                .padding(.top, 12)
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
            if let error = transactionViewModel.errorInputAmount {
//                Text("\(error)")
//                    .foregroundStyle(Color("ColorCherryRed"))
//                    .font(.system(size: 16, weight: .semibold))
//                    .padding(.bottom, 16)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 30)
            }
            if transactionViewModel.typeSelectedOption.localizedCaseInsensitiveContains("expense") {
                SelectOptionView(
                    label: "",
                    selectedOption: $transactionViewModel.categorySelectedOption,
                    sheetLabel: "Pick your Category",
                    placeholderString: "Select Category",
                    options: budgetViewModel.budgetCategoryArray,
                    placeholderStringFontSize: 20,
                    height: 54
                ){}
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
            }
            let budgetTypeOptions = ["Weekly", "Monthly", "Yearly"]
            SelectOptionView(
                label: "",
                selectedOption: $transactionViewModel.budgetTypeSelectedOption,
                sheetLabel: "Pick your Budget Type",
                placeholderString: "Select Budget Type", 
                options: budgetTypeOptions,
                placeholderStringFontSize: 20,
                height: 54,
                sheetHeight: budgetTypeOptions.count > 3 ? nil : 291
            ){}
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
            SelectOptionView<String, VStack>(
                label: "",
                selectedOption: $transactionViewModel.pickdate,
                sheetLabel: "Date",
                placeholderString: "Select Date",
                placeholderStringFontSize: 20,
                height: 54,
                dismiss: true,
                content: {
                    VStack(alignment: .center, spacing: 10) {
                        DatePicker("", selection: $transactionViewModel.selectedDate2, displayedComponents: .date)
                            .datePickerStyle(.wheel).foregroundStyle(.white)
                            .onChange(of: transactionViewModel.selectedDate2) { newDate in
                                transactionViewModel.pickdate = formatDate(date: newDate)
                            }
                            .onAppear {
                                transactionViewModel.pickdate = formatDate(date: Date())
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer()
                        Text("\(formatDate(date: transactionViewModel.selectedDate2))")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
            })
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
                .frame(height: 54)
                .overlay {
                    VStack {
                        BottomLineTextFieldView(
                            label: "",
                            placeholder: "Description",
                            fontColor: .black,
                            textFieldFontSize: 20, 
                            placeholderFontSize: 20,
                            textInputVal: $transactionViewModel.descriptionVal
                        )
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
            SelectOptionView(
                label: "",
                selectedOption: $transactionViewModel.walletSecletedOption,
                sheetLabel: "Pick your Wallet Type",
                placeholderString: "Select Wallet",
                options: ["Cash", "Paypal", "Apple", "Samsung Pay", "Amazon Pay"],
                placeholderStringFontSize: 20,
                height: 54
            ){}
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
            if !transactionViewModel.isAddAttachmentSuccess {
                Spacer()
                Button(action: {
                    transactionViewModel.addAttachment = true
                }, label: {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(height: 58)
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
                    if let avatarImg = transactionViewModel.avatarImage {
                        avatarImg
                            .resizable()
                            .scaledToFill()
                            .background(.red)
                            .frame(width: 112, height: 112)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                    Circle()
                        .fill(.secondary)
                        .frame(width: 28, height: 28)
                        .overlay {
                            Button(action: {
                                transactionViewModel.avatarItem = nil
                                transactionViewModel.avatarImage = nil
                                transactionViewModel.isAddAttachmentSuccess = false
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.white)
                            })
                        }
                        .offset(CGSize(width: 49.0, height: -45.0))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
            if !transactionViewModel.isRepeatTransactionSuccess {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 2)
                        .frame(height: 58)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay {
                            VStack(spacing :0) {
                                HStack(alignment: .center){
                                    VStack(alignment: .leading) {
                                        Text("Repeat")
                                            .font(.system(size: 18, weight: .medium))
                                        Text("Repeat transaction")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                    CustomToggleView(isOn: $transactionViewModel.repeatTransaction)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 4)
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
                            Text("\(transactionViewModel.frequencySelectedOption)")
                        }.padding(.trailing, 15)
                        VStack {
                            Text("End After").fontWeight(.medium).frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(formatDate(date: transactionViewModel.selectedDate))")
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
                .padding(.vertical, 5)
            }
            Spacer()
            
        }
        .sheet(isPresented: $transactionViewModel.addAttachment) {
            VStack {
                HStack(spacing: 60) {
                    VStack {
                        PhotosPicker("", selection: $transactionViewModel.avatarItem, matching: .images)
                            .buttonStyle(CustomImageButtonStyle(iconName: "photo", labelName: "Image" ,width: 107, height: 91))
                    }
                    .onChange(of: transactionViewModel.avatarItem) { _ in
                        transactionViewModel.isAddAttachmentSuccess = true
                        transactionViewModel.addAttachment = false
                        Task {
                            if let data = try? await transactionViewModel.avatarItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    transactionViewModel.avatarImage = Image(uiImage: uiImage)
                                    return
                                }
                            }
                            
                            print("Failed")
                        }
                    }
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
        .sheet(isPresented: $transactionViewModel.repeatTransaction) {
            VStack {
                let budgetTypeOptionsList = ["Monthly", "Weekly", "Yearly"]
                SelectOptionView(
                    label: "",
                    selectedOption: $transactionViewModel.frequencySelectedOption,
                    sheetLabel: "Pick your Frequency",
                    placeholderString: "Frequency",
                    options: budgetTypeOptionsList,
                    iconColor: .white,
                    placeholderStringColor: .white,
                    placeholderStringFontSize: 20,
                    sheetHeight: 291,
                    strokeColor: .white
                ){}
                    .padding(.vertical, 6)
                    .padding(.horizontal, 15)
                SelectOptionView<String, VStack>(
                    label: "",
                    selectedOption: $transactionViewModel.endAfter,
                    sheetLabel: "Date",
                    placeholderString: "End After",
                    iconColor: .white,
                    placeholderStringColor: .white,
                    placeholderStringFontSize: 20,
                    strokeColor: .white,
                    dismiss: true,
                    content: {
                    VStack(spacing: 10) {
                        DatePicker("", selection: $transactionViewModel.selectedDate, displayedComponents: .date)
                            .datePickerStyle(.wheel).foregroundStyle(.white)
                            .onChange(of: transactionViewModel.selectedDate) { newDate in
                                transactionViewModel.endAfter = formatDate(date: newDate)
                            }
                            .onAppear {
                                transactionViewModel.endAfter = formatDate(date: Date())
                            }
                        
                        Spacer()
                        Text("\(formatDate(date: transactionViewModel.selectedDate))")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                })
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                Button(action: {
                    transactionViewModel.repeatTransaction = false
                    transactionViewModel.isRepeatTransactionSuccess = true
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

struct CustomImageButtonStyle: ButtonStyle {
    var iconName: String
    var labelName: String
    var width: CGFloat
    var height: CGFloat
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(Color("ColorVividBlue"))
                    .frame(width: width, height: height)
                    .opacity(configuration.isPressed ? 0.8 : 1)
                    .overlay(
                        VStack {
                            Image(systemName: iconName)
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                            Text(labelName)
                                .font(.system(size: 22))
                                .foregroundStyle(.white)
                        }
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
