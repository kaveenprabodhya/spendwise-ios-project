//
//  TransactionView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct TransactionView: View {
    @State var sortedBy: String = ""
    @State var defaultVal: Int = 0
    @State var isOnFilterClicked: Bool = false
    @State var isOnCategoryClicked: Bool = false
    @State var isReportClicked: Bool = false
    @State private var checkedStates: [Bool] =  Array(repeating: false, count: 18)
    @ObservedObject var transactionViewModel: TransactionViewModel = TransactionViewModel()
    @ObservedObject var budgetViewModel: BudgetViewModel = BudgetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                SelectOptionView(label: "", selectedOption: $sortedBy, sheetLabel: "Select an Option", placeholderString: "Monthly", options: ["Monthly", "Weekly", "Yearly"], iconColor: .white, placeholderStringColor: .white, placeholderStringFontSize: 18, height: 44 , cornerRadius: 40, strokeColor: .white){}
                    .frame(width: 116)
                Spacer()
                Button(action: {
                    isOnFilterClicked = true
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundStyle(.white)
                        }
                })
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 18)
            
            Button(action: {
                isReportClicked = true
            }, label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white.opacity(0.3))
                    .frame(width: 343, height: 48)
                    .overlay {
                        HStack {
                            Text("See your financial report")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 15)
                    }
            })
            .padding(.bottom, 18)
            .navigationDestination(isPresented: $isReportClicked) {
                FinancialReportView()
            }
            ScrollView() {
                ForEach(transactionViewModel.transactionsArray) { transaction in
                    TransactionListItem(iconName: "basket.fill", transactionName: transaction.transactionObject.category, transactionAmount: transaction.transactionObject.amount, transactionDescription: transaction.transactionObject.description, transactionTime: formattedTime(from: transaction.transactionObject.date), transactionType: transaction.category)
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isOnFilterClicked, content: {
            VStack(spacing: 0) {
                VStack {
                HStack {
                    Text("Filter Transaction")
                        .foregroundStyle(.black)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color("ColorEtherealMist"))
                            .frame(width: 88, height: 48)
                            .overlay {
                                Text("Reset")
                                    .foregroundStyle(Color("ColorVividBlue"))
                                    .font(.system(size: 18, weight: .medium))
                            }
                    })
                }
                .padding(.horizontal, 15)
                .padding(.top, 8)
                VStack(spacing: 0) {
                    Text("Filter By")
                        .foregroundStyle(.black)
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.gray)
                            .frame(width: 98, height: 48)
                            .overlay {
                                Text("Income")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18, weight: .medium))
                            }
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.white)
                            .frame(width: 98, height: 48)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(.gray, lineWidth: 2)
                                    .frame(width: 98, height: 48)
                                    .overlay {
                                        Text("Income")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 18, weight: .medium))
                                    }
                            }
                    }
                    .padding(.horizontal, 15)
                    Text("Sort By")
                        .foregroundStyle(.black)
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 8)
                    let sortList: [String] = ["Highest", "Lowest","Newest", "Oldest"]
                    let columns: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(sortList, id: \.self) { sort in
                            VGridListItem(label: sort)
                        }
                    }
                    .padding(.bottom, 8)
                    Text("Category")
                        .foregroundStyle(.black)
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 8)
                    Button {
                        isOnCategoryClicked = true
                    } label: {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                            .frame(height: 53)
                            .overlay {
                                HStack(alignment: .center) {
                                    Text("Choose Category")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text("\(defaultVal) count")
                                        .foregroundStyle(Color(.systemGray))
                                        .font(.system(size: 18, weight: .medium))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(Color("ColorVividBlue"))
                                }
                                .padding(.horizontal, 18)
                            }
                            .padding(.bottom, 10)
                    }
                    .sheet(isPresented: $isOnCategoryClicked, content: {
                        VStack {
                            VStack {
                                ScrollView {
                                    ForEach(budgetViewModel.budgetCategoryArray.indices, id: \.self) { index in
                                                    HStack {
                                                        Text(budgetViewModel.budgetCategoryArray[index].name)
                                                        Spacer()
                                                        CheckboxView(checked: self.$checkedStates[index])
                                                    }
                                                    .padding()
                                                }
                                }
                                .padding(.vertical, 6)
                            }
                            
                            Button {
                                
                            } label: {
                                
                            }
                            .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 383, height: 56, label: "Apply", cornerRadius: 25))
                        }
                        .presentationDetents([.medium, .large])
                        .presentationCornerRadius(16)
                        .presentationDragIndicator(.visible)
                    })
                    .padding(.horizontal, 35)
                    Spacer()
                    Button {
                        
                    } label: {
                        
                    }
                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 383, height: 56, label: "Apply", cornerRadius: 25))
                }
                }
                Spacer()
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(16)
            .presentationDragIndicator(.visible)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("ColorElectricIndigo"), Color("ColorCerulean")]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading)
        )
        .navigationBarHidden(true)
        
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct CheckboxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .foregroundColor(checked ? .blue : .black)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct VGridListItem: View {
    var label: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(.white)
            .frame(width: 98, height: 48)
            .overlay {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(.gray, lineWidth: 2)
                    .frame(width: 98, height: 48)
                    .overlay {
                        Text(label)
                            .foregroundStyle(.black)
                            .font(.system(size: 18, weight: .medium))
                    }
            }
    }
}

struct TransactionListItem: View {
    var iconName: String
    var transactionName: String
    var transactionAmount: Double
    var transactionDescription: String
    var transactionTime: String
    var transactionType: TransactionCategory
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.white)
                .frame(width: 385, height: 99)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green.opacity(0.4))
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image(systemName: "\(iconName)")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.green)
                            }
                        VStack(spacing: 10) {
                            HStack {
                                Text("\(transactionName)")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(.black)
                                Spacer()
                                Text("\(transactionType == .expense ? "-" : "+")\(formatCurrency(value: transactionAmount))")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(transactionType == .expense ? .red : .green)
                            }
                            HStack {
                                Text("\(transactionDescription)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(Color("ColorSteelGray"))
                                Spacer()
                                Text("\(transactionTime)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(Color("ColorSteelGray"))
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
        }
        .padding(.horizontal, 15)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
