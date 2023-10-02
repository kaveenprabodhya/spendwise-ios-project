//
//  FinancialReportView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

enum ChartType {
    case lineChart
    case pieChart
}

struct FinancialReportView: View {
    @Environment(\.dismiss) private var dismiss
    @State var sortedByBudgetType: String = ""
    @State var sortedByCategoryOrTxn: String = ""
    @State var isOnSortClicked: Bool = false
    @State var selectedTab: TransactionCategory = .expense
    @State var selectedGraphTab: ChartType = .lineChart
    
    var body: some View {
        VStack{
            HStack {
                SelectOptionView(label: "", selectedOption: $sortedByBudgetType, sheetLabel: "Select an Option", placeholderString: "Monthly", options: ["Monthly", "Weekly", "Yearly"], iconColor: .black, placeholderStringColor: .black, placeholderStringFontSize: 18, height: 44 , cornerRadius: 40, strokeColor: .black){}
                    .frame(width: 116)
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        selectedGraphTab = .lineChart
                    } label: {
                        UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                            .fill(selectedGraphTab == .lineChart ? Color("ColorVividBlue") : .white)
                            .frame(width: 48, height: 48)
                            .overlay {
                                if selectedGraphTab != .lineChart {
                                    UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                                        .stroke(.gray, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                } else {
                                    UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                                        .fill(.clear)
                                        .frame(width: 48, height: 48)
                                }
                            }
                            .overlay {
                                Image(systemName: "chart.xyaxis.line")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundStyle(selectedGraphTab != .lineChart ? Color("ColorVividBlue") : .white)
                            }
                    }
                    
                    Button {
                        selectedGraphTab = .pieChart
                    } label: {
                        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 16, topTrailingRadius: 16)
                            .fill(selectedGraphTab == .pieChart ? Color("ColorVividBlue") : .white)
                            .frame(width: 48, height: 48)
                            .overlay {
                                if selectedGraphTab != .pieChart {
                                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 16, topTrailingRadius: 16)
                                        .stroke(.gray, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                } else {
                                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 16, topTrailingRadius: 16)
                                        .fill(.clear)
                                        .frame(width: 48, height: 48)
                                }
                            }
                            .overlay {
                                Image(systemName: "chart.pie.fill")
                                    .font(.system(size: 28, weight: .medium))
                                    .foregroundStyle(selectedGraphTab != .pieChart ? Color("ColorVividBlue") : .white)
                            }
                    }
                }
            }
            .padding(.horizontal, 16)
            VStack(alignment: .leading) {
                Text("Total Amount")
                    .font(.system(size: 24, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            VStack {
                TabView(selection: $selectedGraphTab) {
                    if selectedGraphTab == .lineChart {
                        LineChartView()
                    }
                    if selectedGraphTab == .pieChart {
                        PieChartView()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            VStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.gray.opacity(0.5))
                    .frame(width: 392, height: 64)
                    .overlay {
                        HStack(spacing: 0) {
                            Button {
                                selectedTab = .expense
                            } label: {
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(selectedTab == .expense ? Color("ColorVividBlue") : .clear)
                                    .frame(width: 182, height: 56)
                                    .padding(5)
                                    .overlay {
                                        Text("Expense")
                                            .font(.system(size: 22, weight: .medium))
                                            .foregroundStyle(.white)
                                    }
                            }
                            
                            Button {
                                selectedTab = .income
                            } label: {
                                RoundedRectangle(cornerRadius: 32)
                                    .fill(selectedTab == .income ? Color("ColorVividBlue") : .clear)
                                    .frame(width: 182, height: 56)
                                    .padding(5)
                                    .overlay {
                                        Text("Income")
                                            .font(.system(size: 22, weight: .medium))
                                            .foregroundStyle(.white)
                                    }
                            }
                        }
                    }
            }
            HStack {
                SelectOptionView(label: "", selectedOption: $sortedByCategoryOrTxn, sheetLabel: "Select an Option", placeholderString: "Transaction", options: ["Transaction", "Category"], iconColor: .black, placeholderStringColor: .black, placeholderStringFontSize: 16, height: 44, cornerRadius: 40, strokeColor: .gray.opacity(0.5)){}
                    .frame(width: 136)
                Spacer()
                Button(action: {
                    isOnSortClicked = true
                }, label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.5), lineWidth: 2)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image("sort-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                })
            }
            .padding(.horizontal, 15)
            VStack {
                TabView(selection: $selectedTab) {
                    if selectedTab == .expense {
                        ExpenseTabView()
                    }
                    if selectedTab == .income {
                        IncomeTabView()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Financial Report")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color.black)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
    }
}

struct IncomeTabView: View {
    var body: some View {
        ScrollView() {
            TransactionListItem(iconName: "cart", transactionName: "Shopping", transactionAmount: 123.00, transactionDescription: "Buy some cloths", transactionTime: "16:00", transactionType: .income)
        }
    }
}

struct ExpenseTabView: View {
    var body: some View {
        ScrollView() {
            TransactionListItem(iconName: "basket", transactionName: "Groceries", transactionAmount: 3230, transactionDescription: "Buy some groceries", transactionTime: "16:00", transactionType: .expense)
        }
    }
}

struct LineChartView: View {
    var body: some View {
        VStack {
            Text("line Chart")
        }
    }
}

struct PieChartView: View {
    var body: some View {
        VStack {
            Text("Pie Chart")
        }
    }
}


struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
