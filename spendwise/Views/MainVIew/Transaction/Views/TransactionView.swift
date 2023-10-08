//
//  TransactionView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct TransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @State var sortedBy: String = "Monthly"
    @State var defaultVal: Int = 0
    @State var isOnFilterClicked: Bool = false
    @State var isOnCategoryClicked: Bool = false
    @State var isReportClicked: Bool = false
    @State var filterByIncome: Bool = false
    @State var filterByExpense: Bool = false
    @State var sortByHighest: Bool = false
    @State var sortByLowest: Bool = false
    @State var sortByNewest: Bool = false
    @State var sortByOldest: Bool = false
    @State private var checkedStates: [Bool] =  Array(repeating: false, count: 18)
    @ObservedObject var transactionViewModel: TransactionViewModel = TransactionViewModel()
    @ObservedObject var budgetViewModel: BudgetViewModel = BudgetViewModel()
    
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        NavigationStack {
        VStack {
            HStack {
                SelectOptionView(
                    label: "",
                    selectedOption: $sortedBy,
                    sheetLabel: "Select an Option",
                    placeholderString: "Monthly",
                    options: ["Monthly", "Weekly", "Yearly"],
                    iconColor: .white,
                    placeholderStringColor: .white,
                    placeholderStringFontSize: 18,
                    height: 44,
                    sheetHeight: 291,
                    cornerRadius: 40,
                    strokeColor: .white
                ){}
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
            TabView() {
                if sortedBy == "Weekly" {
                    WeeklyTransactions(transactionViewModel: transactionViewModel, budgetViewModel: budgetViewModel, months: months)
                } else if sortedBy == "Monthly" {
                    MonthlyTransactions(transactionViewModel: transactionViewModel, budgetViewModel: budgetViewModel, months: months)
                } else if sortedBy == "Yearly" {
                    YearlyTransactions(transactionViewModel: transactionViewModel, budgetViewModel: budgetViewModel)
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            if let currentUser = UserManager.shared.getCurrentUser() {
                transactionViewModel.fetchAllTransactionData(currentUser: currentUser)
            }
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
                            filterByIncome = false
                            filterByExpense = false
                            sortByHighest = false
                            sortByLowest = false
                            sortByNewest = false
                            sortByOldest = false
                        }, label: {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color(.systemGray3))
                                .frame(width: 88, height: 38)
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
                                .fill(filterByIncome ? .gray : .white)
                                .frame(width: 98, height: 48)
                                .overlay {
                                    if !filterByIncome {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .stroke(.gray, lineWidth: 2)
                                            .frame(width: 98, height: 48)
                                            .overlay {
                                                Text("Income")
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 18, weight: .medium))
                                            }
                                    } else {
                                        Text("Income")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 18, weight: .medium))
                                    }
                                }
                                .onTapGesture {
                                    filterByIncome.toggle()
                                }
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(filterByExpense ? .gray : .white)
                                .frame(width: 98, height: 48)
                                .overlay {
                                    if !filterByExpense {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .stroke(.gray, lineWidth: 2)
                                            .frame(width: 98, height: 48)
                                            .overlay {
                                                Text("Expense")
                                                    .foregroundStyle(.black)
                                                    .font(.system(size: 18, weight: .medium))
                                            }
                                    } else {
                                        Text("Expense")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 18, weight: .medium))
                                    }
                                }
                                .onTapGesture {
                                    filterByExpense.toggle()
                                }
                        }
                        .padding(.horizontal, 15)
                        Text("Sort By")
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 8)
                        let sortList: [(String, Binding<Bool>)] = [
                            ("Highest", $sortByHighest),
                            ("Lowest", $sortByLowest),
                            ("Newest", $sortByNewest),
                            ("Oldest", $sortByOldest)
                        ]
                        let columns: [GridItem] = Array(repeating: .init(.fixed(100)), count: 3)
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(sortList, id: \.0) { sortLabel, boolVal in
                                VGridListItem(label: sortLabel, clicked: boolVal)
                            }
                        }
                        .padding(.bottom, 8)
                        Text("Category")
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 15)
                            .padding(.bottom, 14)
                        Button {
                            isOnCategoryClicked = true
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
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
                                    let trueCount = checkedStates.reduce(0) { (count, value) in
                                        return count + (value ? 1 : 0)
                                    }
                                    
                                    defaultVal = trueCount
                                    isOnCategoryClicked = false
                                } label: {}
                                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 383, height: 56, label: "Apply", cornerRadius: 25))
                            }
                            .presentationDetents([.medium, .large])
                            .presentationCornerRadius(25)
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
            .presentationCornerRadius(25)
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
        
    }
    
    func countTrueValues() -> Int {
        return checkedStates.filter { $0 }.count
    }
}

struct MonthlyTransactions: View {
    @ObservedObject var transactionViewModel: TransactionViewModel
    @ObservedObject var budgetViewModel: BudgetViewModel
    var months: [String]
    @State var index: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $index,
                    content:  {
                ForEach(months.indices, id: \.self) { index in
                    TransactionList(
                        transactionByMonthOrWeek: transactionViewModel.transactionByMonth,
                        budgetCategoryArray: budgetViewModel.budgetCategoryArray,
                        formattedTime: transactionViewModel.formattedTime,
                        monthString: months[index]
                    )
                        .tag(index)
                }
            })
        }
    }
}

struct WeeklyTransactions: View {
    @ObservedObject var transactionViewModel: TransactionViewModel
    @ObservedObject var budgetViewModel: BudgetViewModel
    var months: [String]
    @State var index: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $index,
                    content:  {
                ForEach(months.indices, id: \.self) { index in
                    TransactionList(
                        transactionByMonthOrWeek: transactionViewModel.transactionByWeek,
                        budgetCategoryArray: budgetViewModel.budgetCategoryArray,
                        formattedTime: transactionViewModel.formattedTime,
                        monthString:  months[index]
                    )
                        .tag(index)
                }
            })
        }
    }
}

struct YearlyTransactions: View {
    @ObservedObject var transactionViewModel: TransactionViewModel
    @ObservedObject var budgetViewModel: BudgetViewModel
    @State var index: Int = 0
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var years: [String] {
        (0..<10).map { String(currentYear + $0) }
    }

    var body: some View {
        VStack {
            TabView(selection: $index,
                    content:  {
                ForEach(years.indices, id: \.self) { index in
                    TransactionList(
                        transactionByYear: transactionViewModel.transactionByYear,
                        budgetCategoryArray: budgetViewModel.budgetCategoryArray,
                        formattedTime: transactionViewModel.formattedTime,
                        yearString: years[index]
                    )
                    .tag(index)
                }
            })
        }
//        .onAppear {
//            transactionViewModel.printTransactionByYear(transactionViewModel.transactionByYear)
//        }
    }
}

struct TransactionList: View {
    var transactionByMonthOrWeek: [(String, [BudgetTransaction])]?
    var transactionByYear: [(String, [BudgetTransaction])]?
    var budgetCategoryArray: [BudgetCategory]
    var formattedTime: (Date) -> String
    var monthString: String?
    var yearString: String?
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if let monthVal = monthString {
                    Text("\(monthVal)")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                    Spacer()
                    if monthVal.localizedCaseInsensitiveContains("january") {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.trailing, 4)
                    }
                }
                if let yearVal = yearString {
                    Text("\(yearVal)")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                    Spacer()
                    if yearVal.localizedCaseInsensitiveContains(String(Calendar.current.component(.year, from: Date()))) {
                        Image(systemName: "arrowshape.forward.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.trailing, 4)
                    }
                }
            }
            .padding(.horizontal, 12)
            GeometryReader { geometry in
                ScrollView() {
                    if let transactionByMonthOrWeek = transactionByMonthOrWeek {
                        ForEach(transactionByMonthOrWeek, id: \.0) { month, transactions in
                            if let monthVal = monthString {
                                if monthVal == month {
                                    ForEach(transactions) { budgetTransaction in
                                        ForEach(budgetCategoryArray) { category in
                                            if budgetTransaction.transaction.budgetCategory.localizedCaseInsensitiveContains(category.name) {
                                                NavigationLink {
                                                    TransactionDetailView(budgetTransaction: budgetTransaction)
                                                } label: {
                                                    TransactionListItem(iconName: category.iconName, iconColor: Color(category.primaryBackgroundColor), transactionName: budgetTransaction.transaction.budgetCategory, transactionAmount: budgetTransaction.transaction.amount, transactionDescription: budgetTransaction.transaction.description, transactionTime: formattedTime(budgetTransaction.transaction.date), transactionType: budgetTransaction.type)
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    VStack {
                                        Text("No transactions Found.")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                            }
                        }
                    }
                    if let transactionByYear = transactionByYear {
                        ForEach(transactionByYear, id: \.0) { year, transactions in
                            if let yearVal = yearString {
                                if yearVal == year {
                                    ForEach(transactions) { budgetTransaction in
                                        ForEach(budgetCategoryArray) { category in
                                            if budgetTransaction.transaction.budgetCategory.localizedCaseInsensitiveContains(category.name) {
                                                NavigationLink {
                                                    TransactionDetailView(budgetTransaction: budgetTransaction)
                                                } label: {
                                                    TransactionListItem(iconName: category.iconName, iconColor: Color(category.primaryBackgroundColor), transactionName: budgetTransaction.transaction.budgetCategory, transactionAmount: budgetTransaction.transaction.amount, transactionDescription: budgetTransaction.transaction.description, transactionTime: formattedTime(budgetTransaction.transaction.date), transactionType: budgetTransaction.type)
                                                }

                                                
                                            }
                                        }
                                    }
                                }
                                else {
                                    VStack {
                                        Text("No transactions Found.")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                }
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    func getMonthNumber(monthString: String) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        if let date = formatter.date(from: monthString) {
            let calendar = Calendar.current
            let monthNumber = calendar.component(.month, from: date)
            return monthNumber
        } else {
            return nil
        }
    }
    
    func getMonth(from date: Date) -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        return monthFormatter.string(from: calendar.date(from: DateComponents(year: 2000, month: month, day: 1))!)
    }
    
    func getYear(from date: Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return String(year)
    }
}

struct TransactionListItem: View {
    var iconName: String
    var iconColor: Color?
    var transactionName: String
    var transactionAmount: Double
    var transactionDescription: String
    var transactionTime: String
    var transactionType: TransactionCategory
    var fillColor: Color?
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(fillColor != nil ? fillColor! : .white)
                .frame(width: 385, height: 99)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(iconColor != nil ? iconColor!.opacity(0.4) : .green.opacity(0.4))
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image(systemName: "\(iconName)")
                                    .font(.system(size: 32))
                                    .foregroundStyle(iconColor != nil ? iconColor! : .green)
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
    @Binding var clicked: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(clicked ? .gray : .white)
            .frame(width: 98, height: 48)
            .overlay {
                if !clicked {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(.gray, lineWidth: 2)
                        .frame(width: 98, height: 48)
                        .overlay {
                            Text("Expense")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .medium))
                        }
                } else {
                    Text("Expense")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .medium))
                }
            }
            .onTapGesture {
                clicked.toggle()
            }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
