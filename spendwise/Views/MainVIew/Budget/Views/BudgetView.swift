//
//  BudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct BudgetView: View {
    @State private var selectedTab: BudgetTypeOption = .monthly
    @State private var currentPage: Int = 0
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel()
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab){
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: viewModel.budgetArray)
                    .tag(BudgetTypeOption.weekly)
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: viewModel.budgetArray)
                    .tag(BudgetTypeOption.monthly)
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: viewModel.budgetArray)
                    .tag(BudgetTypeOption.yearly)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(.clear)
                    .overlay(alignment: .center) {
                        TabButtons(selectedTab: $selectedTab)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(height: 95)
            }
        }
        .onAppear{
            viewModel.fetchData()
        }
    }
}

struct TabButtons: View {
    @Binding var selectedTab: BudgetTypeOption
    
    var body: some View {
        HStack(spacing: 25) {
            Button(action: {
                withAnimation {
                    self.selectedTab = .weekly
                }
            }) {
                TabButton(label: "Weekly", isSelected: selectedTab == .weekly)
            }
            Button(action: {
                withAnimation {
                    self.selectedTab = .monthly
                }
            }) {
                TabButton(label: "Monthly", isSelected: selectedTab == .monthly)
            }
            Button(action: {
                withAnimation {
                    self.selectedTab = .yearly
                }
            }) {
                TabButton(label: "Yearly", isSelected: selectedTab == .yearly)
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: 65)
        .background(.white.opacity(0.3))
    }
}

struct TabButton: View {
    let label: String
    let isSelected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(isSelected ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
            .frame(width: 108, height: 46)
            .overlay {
                Text(label)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? .white : .black)
            }
    }
}

struct PageTabView: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    var budgets: [Budget]
    
    var yearlyBudgets: [Budget] {
        budgets.filter { $0.budgetType.type == .yearly }
    }
    
    var monthlyBudgets: [Budget] {
        budgets.filter { $0.budgetType.type == .monthly }
    }
    
    var weeklyBudgets: [Budget] {
        budgets.filter { $0.budgetType.type == .weekly }
    }
    
    func printBudgets(budget: [Budget]) {
        for budget in budget {
            print(budget.budgetType.type)
            print(budget.category[0].name)
            print(budget.allocatedAmount)
        }
    }
    
    var body: some View {
        if selectedTab == .monthly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: monthlyBudgets)
                .onAppear{
                    let _: () = printBudgets(budget: monthlyBudgets)
                }
        } else if selectedTab == .weekly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: weeklyBudgets)
        } else if selectedTab == .yearly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, budgets: yearlyBudgets)
        }
    }
}

struct BottomBudgetSheetOverView: View {
    var heightOfSheet: CGFloat = UIScreen.main.bounds.height * 3/4
    @Binding var selectedTab: BudgetTypeOption
    @State private var date: String = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
    @Binding var currentPage: Int
    var budgets: [Budget]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ))
                    .frame(width: geometry.size.width, height: 220)
                
            }
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear.frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    
                }
                .overlay(content: {
                    GeometryReader { geometry in
                        VStack {
                            BottomBudgetSheet(selectedTab: $selectedTab, date: $date, currentPage: $currentPage, sheetHeight: heightOfSheet, budgetArray: budgets)
                        }
                        .frame(width: geometry.size.width, height: heightOfSheet)
                        .frame(maxHeight: .infinity, alignment: .bottom )
                    }
                })
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct BottomBudgetSheet: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var date: String
    @Binding var currentPage: Int
    var spentAmountForLast7Days: Double = 0
    var sheetHeight: CGFloat
    
    var budgetArray: [Budget]
    
    var allocatedTotalBudgetAmountByMonth: [String: [String: Double]] {
        var totalAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allBudgets {
            for (month, budgets) in data {
                var monthData: [String: Double] = totalAmounts[type] ?? [:]
                let totalAmount = budgets.reduce(0) { result, budget in
                    result + budget.allocatedAmount
                }
                monthData[month] = totalAmount
                totalAmounts[type] = monthData
            }
        }
        
        return totalAmounts
    }
    
    var totalAmountSpentByMonth: [String: [String: Double]] {
        var totalAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allBudgets {
            for (month, budgets) in data {
                var monthData: [String: Double] = totalAmounts[type] ?? [:]
                let totalAmount = budgets.reduce(0) { result, budget in
                    result + budget.currentAmountSpent
                }
                monthData[month] = totalAmount
                totalAmounts[type] = monthData
            }
        }
        
        return totalAmounts
    }
    
    var totalAmountRemainingByMonth: [String: [String: Double]] {
        let allocatedTotalAmounts = allocatedTotalBudgetAmountByMonth
        let totalAmountsSpent = totalAmountSpentByMonth
        
        var remainingAmounts: [String: [String: Double]] = [:]
        
        for (type, data) in allocatedTotalAmounts {
            var monthData: [String: Double] = [:]
            for (month, allocatedAmount) in data {
                if let spentAmount = totalAmountsSpent[type]?[month] {
                    monthData[month] = allocatedAmount - spentAmount
                } else {
                    monthData[month] = allocatedAmount
                }
            }
            remainingAmounts[type] = monthData
        }
        
        return remainingAmounts
    }
    
    var progressValueByMonth: [String: [String: Float]] {
        let totalBudgets = allocatedTotalBudgetAmountByMonth
        let spentAmounts = totalAmountSpentByMonth
        
        var progressValues: [String: [String: Float]] = [:]
        
        for (type, data) in totalBudgets {
            var monthlyProgressData: [String: Float] = [:]
            for (month, totalBudget) in data {
                if let spentAmount = spentAmounts[type]?[month] {
                    let totalBudgetFloat = Float(totalBudget)
                    let spentAmountFloat = Float(spentAmount)
                    if totalBudgetFloat == 0 {
                        monthlyProgressData[month] = 0
                    } else {
                        let progress = spentAmountFloat / totalBudgetFloat
                        monthlyProgressData[month] = min(1.0, max(0.0, progress))
                    }
                } else {
                    monthlyProgressData[month] = 0
                }
            }
            progressValues[type] = monthlyProgressData
        }
        
        return progressValues
    }
    
    // type - month - budget
    var budgetByMonth:  [(String, [(String, [Budget])])]{
        let monthlyBudgets = budgetArray.filter { budget in
            if case .monthOnly = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: monthlyBudgets) { budget -> String in
            if case .monthOnly(let month) = budget.budgetType.date {
                return DateFormatter().monthSymbols[month - 1]
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("monthly", [(key, values)])
        }
        return result
    }
    //type - range - budget
    var budgetByWeek:  [(String, [(String, [Budget])])] {
        let weeklyBudgets = budgetArray.filter { budget in
            if case .dateRange = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: weeklyBudgets) { budget -> String in
            if case .dateRange(let month, let startDate, let endDate) = budget.budgetType.date {
                let monthName = DateFormatter().monthSymbols[month - 1]
                let weekDescription = "\(startDate)-\(endDate)"
                return "\(monthName), \(weekDescription)"
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("weekly", [(key, values)])
        }
        return result
    }
    //type - year - budget
    var budgetByYear:  [(String, [(String, [Budget])])] {
        let yearlyBudgets = budgetArray.filter { budget in
            if case .yearOnly = budget.budgetType.date {
                return true
            }
            return false
        }
        let groupedBudgets = Dictionary(grouping: yearlyBudgets) { budget -> String in
            if case .yearOnly(let year) = budget.budgetType.date {
                return String(year)
            }
            return ""
        }
        let result = groupedBudgets.map { (key, values) in
            return ("yearly", [(key, values)])
        }
        return result
    }
    
    var allBudgets: [(String, [(String, [Budget])])] {
        return budgetByMonth + budgetByWeek + budgetByYear
    }
    
    var limitForBudgetType: [(String, [(String, Double)])] {
        var limits: [(String, [(String, Double)])] = []
        
        for (budgetType, monthsAndBudgets) in allBudgets {
            for (month, budgets) in monthsAndBudgets {
                if let firstBudget = budgets.first {
                    let limit = firstBudget.budgetType.limit
                    limits.append((budgetType, [(month, limit)]))
                }
            }
        }
        
        return limits
    }
    
    func printBudgets(budgets: [(String, [(String, [Budget])])]) {
        for (type, dateBudgets) in budgets {
            print("Type: \(type)")
            for (month, budgets) in dateBudgets {
                print("Month: \(month)")
                for budget in budgets {
                    print("  Budget ID: \(budget.id)")
                    print("  Allocated Amount: $\(budget.allocatedAmount)")
                    print("  date range: $\(budget.budgetType.date)")
                    print("        -------------")
                }
                print("-------------")
            }
        }
    }
    
    var body: some View{
        UnevenRoundedRectangleViewShape(
            topLeftRadius: 30,
            topRightRadius: 30,
            bottomLeftRadius: 0,
            bottomRightRadius: 0
        )
        .fill(.white)
        .frame(height: sheetHeight)
        .overlay {
            if budgetArray.isEmpty {
                VStack(spacing: 0) {
                    BudgetOverView(
                        totalBudgetAmount: [:],
                        progressValue: [:],
                        usedAmount: [:],
                        selectedTab: $selectedTab,
                        date: $date,
                        currentPage: $currentPage,
                        budgetArray: []
                    )
                    VStack(spacing: 0) {
                        Image("budget-empty-screen")
                            .resizable()
                            .scaledToFit()
                    }.overlay {
                        VStack(spacing: 0) {
                            Text(
                                     """
                                     Looks Like, You don’t have a budget.
                                     Let’s make one so you in control.
                                     """
                            )
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18, weight: .medium))
                            Spacer()
                        }
                        .offset(y: -10)
                        .padding()
                    }
                    Spacer()
                }
            }
            else {
                VStack(spacing : 0) {
                    BudgetOverView(
                        totalBudgetAmount: allocatedTotalBudgetAmountByMonth,
                        progressValue: progressValueByMonth,
                        usedAmount: totalAmountSpentByMonth,
                        selectedTab: $selectedTab,
                        date: $date,
                        currentPage: $currentPage,
                        budgetArray: allBudgets
                    )
                    VStack(spacing : 0) {
                        if !spentAmountForLast7Days.isNaN {
                            HStack {
                                if selectedTab == .monthly {
                                    Text("You’ve spent")
                                        .font(.system(size: 14, weight: .medium))
                                    Text("LKR \(formatCurrency(value: spentAmountForLast7Days))")
                                        .foregroundColor(Color("ColorVividBlue"))
                                        .font(.system(size: 16, weight: .bold))
                                    
                                    Text("for the past 7 days")
                                        .font(.system(size: 14, weight: .medium))
                                }
                            }.padding()
                        }
                        HStack {
                            Text("What’s left to spend").font(.system(size: 14, weight: .medium))
                            Spacer()
                            if selectedTab == .monthly {
                                if let leftToSpendAmount = totalAmountRemainingByMonth["monthly"]?[date] {
                                    Text("\(formatCurrency(value: leftToSpendAmount))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            else if selectedTab == .weekly {
                                if let leftToSpendAmount = totalAmountRemainingByMonth["weekly"]?.compactMap({ $0.key.contains(date) ? $0.value : nil }).first {
                                    Text("\(formatCurrency(value: leftToSpendAmount))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            else if selectedTab == .yearly {
                                if let leftToSpendAmount = totalAmountRemainingByMonth["yearly"]?[date] {
                                    Text("\(formatCurrency(value: leftToSpendAmount))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            
                        }.padding(.horizontal, 20).padding(.bottom, 4)
                        HStack {
                            Text("Spend Limit per Day").font(.system(size: 14, weight: .medium))
                            Spacer()
                            if selectedTab == .monthly {
                                if let limit = limitForBudgetType.first(where: { $0.0 == "monthly" })?.1.first(where: { $0.0 == date })?.1 {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            if selectedTab == .weekly {
                                if let limit = limitForBudgetType.first(where: { $0.0 == "weekly" })?.1.first(where: { $0.0.contains(date)})?.1 {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                   Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                               }
                            }
                            if selectedTab == .yearly {
                                if let limit = limitForBudgetType.first(where: { $0.0 == "yearly" })?.1.first(where: { $0.0 == date })?.1 {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                   Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                               }
                            }

                        }.padding(.horizontal, 20).padding(.bottom, 4)
                    }.padding(.bottom, 20)
                    GeometryReader { geometry in
                        ScrollView(showsIndicators: false) {
                            VStack {
                                if selectedTab == .monthly {
                                    let filteredBudgets = budgetArray.filter { budget in
                                        if case .monthOnly(let month) = budget.budgetType.date {
                                            return DateFormatter().monthSymbols[month - 1] == date
                                        }
                                        return false
                                    }
                                    if filteredBudgets.isEmpty {
                                        Text("No Budgets Found")
                                            .font(.system(size: 16, weight: .bold))
                                            .padding()
                                    } else {
                                        ForEach(filteredBudgets){ budget in
                                            ForEach(budget.category) { category in
                                                OverallBudgetCategoryCardView(
                                                    primaryBackgroundColor: category.primaryBackgroundColor,
                                                    budgetCategoryName: category.name,
                                                    amountAllocated: budget.allocatedAmount,
                                                    amountSpent: budget.currentAmountSpent,
                                                    numberOfDaysSpent: budget.numberOfDaysSpent,
                                                    footerMessage: budget.footerMessage
                                                )
                                            }
                                        }
                                    }
                                }
                                if selectedTab == .weekly {
                                    let filteredBudgets = budgetArray.filter { budget in
                                        if case .dateRange(let month, _, _) = budget.budgetType.date {
                                                       return DateFormatter().monthSymbols[month - 1] == date
                                                   }
                                                   return false
                                               }
                                    if filteredBudgets.isEmpty {
                                        Text("No Budgets Found")
                                            .font(.system(size: 16, weight: .bold))
                                            .padding()
                                    } else {
                                        ForEach(filteredBudgets) { budget in
                                            ForEach(budget.category) { category in
                                                OverallBudgetCategoryCardView(
                                                    primaryBackgroundColor: category.primaryBackgroundColor,
                                                    budgetCategoryName: category.name,
                                                    amountAllocated: budget.allocatedAmount,
                                                    amountSpent: budget.currentAmountSpent,
                                                    numberOfDaysSpent: budget.numberOfDaysSpent,
                                                    footerMessage: budget.footerMessage
                                                )
                                            }
                                        }
                                    }
                                }
                                if selectedTab == .yearly {
                                    let filteredBudgets = budgetArray.filter { budget in
                                                   if case .yearOnly(let year) = budget.budgetType.date {
                                                       return String(year) == date
                                                   }
                                                   return false
                                               }
                                               
                                               if filteredBudgets.isEmpty {
                                                   Text("No Budgets Found")
                                                       .font(.system(size: 16, weight: .bold))
                                                       .padding()
                                               } else {
                                                   ForEach(filteredBudgets) { budget in
                                                       ForEach(budget.category) { category in
                                                           OverallBudgetCategoryCardView(
                                                               primaryBackgroundColor: category.primaryBackgroundColor,
                                                               budgetCategoryName: category.name,
                                                               amountAllocated: budget.allocatedAmount,
                                                               amountSpent: budget.currentAmountSpent,
                                                               numberOfDaysSpent: budget.numberOfDaysSpent,
                                                               footerMessage: budget.footerMessage
                                                           )
                                                       }
                                                   }
                                               }
                                }
                                    
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
        }
        .onAppear{
//            let _: () = printBudgets(budgets: budgetByWeek)
//            let _: () = printBudgets(budgets: budgetByYear)
//            let _: () = printBudgets(budgets: budgetByMonth)
        }
        .onDisappear{
        }
    }
}

struct BudgetOverView: View {
    var totalBudgetAmount: [String: [String: Double]]
    var progressValue: [String: [String: Float]]
    var usedAmount: [String: [String: Double]]
    @State private var scrollOffset: CGFloat = 0
    @State private var isScrollEnabled = false
    @Binding var selectedTab: BudgetTypeOption
    @Binding var date: String
    @Binding var currentPage: Int
    
    var budgetArray: [(String, [(String, [Budget])])]
    
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var years: [String] {
        (0..<10).map { String(currentYear + $0) }
    }
    
    func getDateOptionAndLabel(for month: String, budgets: [(String, [(String, [Budget])])]) -> (BudgetDateOption, String)? {
        if selectedTab == .monthly || selectedTab == .yearly {
            for (_, data) in budgets {
                for (date, budgets) in data {
                    if date == month {
                        if let budget = budgets.first {
                            switch budget.budgetType.date {
                            case .monthOnly(let month):
                                let label = Calendar.current.monthSymbols[month - 1]
                                return (.monthOnly(month), label)
                            case .yearOnly(let year):
                                let label = "\(year)"
                                return (.yearOnly(year), label)
                            case .dateRange(let month, let startDate, let endDate):
                                let monthString = Calendar.current.monthSymbols[month - 1]
                                let label = "\(monthString), \(startDate)-\(endDate)"
                                return (.dateRange(month, startDate, endDate), label)
                            }
                        }
                    }
                }
            }
        }
        if selectedTab == .weekly {
            for (_, data) in budgets {
                for (date, budgets) in data {
                    if let monthExtracted = extractMonth(from: date, with: "([A-Za-z]+),") {
                        print(monthExtracted)
                        if monthExtracted == month {
                            if let budget = budgets.first {
                                switch budget.budgetType.date {
                                case .monthOnly(let month):
                                    let label = Calendar.current.monthSymbols[month - 1]
                                    return (.monthOnly(month), label)
                                case .yearOnly(let year):
                                    let label = "\(year)"
                                    return (.yearOnly(year), label)
                                case .dateRange(let month, let startDate, let endDate):
                                    let monthString = Calendar.current.monthSymbols[month - 1]
                                    let label = "\(monthString), \(startDate)-\(endDate)"
                                    return (.dateRange(month, startDate, endDate), label)
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func extractMonth(from inputString: String, with pattern: String) -> String? {
        if let range = inputString.range(of: pattern, options: .regularExpression) {
            var month = inputString[range]
            month.removeLast()
            return String(month)
        } else {
            return nil
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                if selectedTab == .weekly || selectedTab == .monthly {
                    if currentPage > 0 {
                        scrollToPage(page: currentPage - 1, array: months)
                    }
                    date = months[currentPage]
                } else if selectedTab == .yearly {
                    if currentPage > 0 {
                        scrollToPage(page: currentPage - 1, array: years)
                    }
                date = years[currentPage]
                }
            } label: {
                Image(systemName: "chevron.left.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color("ColorVividBlue"))
            }
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0){
                        if selectedTab == .monthly {
                            ForEach(months, id: \.self) { month in
                                VStack {
                                    if let (_, label) = getDateOptionAndLabel(for: month, budgets: budgetArray) {
                                        if label == month {
                                            VStack(spacing: 15) {
                                                if let monthlyProgress = progressValue["monthly"]?[label], let monthlySpentAmount = usedAmount["monthly"]?[label] {
                                                    BudgetProgressView(progressValue: monthlyProgress, date: label, usedAmount: monthlySpentAmount)
                                                        .frame(width: 175, height: 175)
                                                }
                                                VStack {
                                                    Text("Monthly Budget")
                                                        .font(.system(size: 16, weight: .bold))
                                                    if let totalBudget = totalBudgetAmount["monthly"]?[month] {
                                                        Text("LKR \(formatCurrency(value: totalBudget))")
                                                            .font(.system(size: 18, weight: .bold))
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                            }
                                            .frame(width: geometry.size.width, alignment: .center)
                                        }
                                    } else {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: 0, date: month, usedAmount: 0)
                                                .frame(width: 175, height: 175)
                                            VStack {
                                                Text("Monthly Budget")
                                                    .font(.system(size: 16, weight: .bold))
                                                Text("LKR \(formatCurrency(value: 0))")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(width: 300, alignment: .leading)
                                .offset(x: scrollOffset)
                                .animation(.easeInOut, value: scrollOffset)
                            }
                        }
                        if selectedTab == .weekly {
                            ForEach(months, id: \.self) { month in
                                VStack {
                                    if let (_, label) = getDateOptionAndLabel(for: month, budgets: budgetArray) {
                                        if let monthExtracted = extractMonth(from: label, with: "([A-Za-z]+),") {
                                            if monthExtracted == month {
                                                VStack(spacing: 15) {
                                                    if let weeklyProgress = progressValue["weekly"]?[label], let weeklySpentAmount = usedAmount["weekly"]?[label] {
                                                        BudgetProgressView(progressValue: weeklyProgress, date: label, usedAmount: weeklySpentAmount)
                                                            .frame(width: 175, height: 175)
                                                    }
                                                    VStack {
                                                        Text("Weekly Budget")
                                                            .font(.system(size: 16, weight: .bold))
                                                        if let totalBudget = totalBudgetAmount["weekly"]?[label] {
                                                            Text("LKR \(formatCurrency(value: totalBudget))")
                                                                .font(.system(size: 18, weight: .bold))
                                                                .multilineTextAlignment(.center)
                                                        }
                                                    }
                                                }
                                                .frame(width: geometry.size.width, alignment: .center)
                                            }
                                        }
                                    }
                                    else {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: 0, date: month, usedAmount: 0)
                                                .frame(width: 175, height: 175)
                                            VStack {
                                                Text("Weekly Budget")
                                                    .font(.system(size: 16, weight: .bold))
                                                Text("LKR \(formatCurrency(value: 0))")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(width: 300, alignment: .leading)
                                .offset(x: scrollOffset)
                                .animation(.easeInOut, value: scrollOffset)
                            }
                        }
                        if selectedTab == .yearly {
                            ForEach(years, id: \.self) { year in
                                VStack {
                                    if let (_, label) = getDateOptionAndLabel(for: year, budgets: budgetArray) {
                                        if label == year {
                                            VStack(spacing: 15) {
                                                if let yearlyProgress = progressValue["yearly"]?[year], let yearlySpentAmount = usedAmount["yearly"]?[year] {
                                                    BudgetProgressView(progressValue: yearlyProgress, date: label, usedAmount: yearlySpentAmount)
                                                        .frame(width: 175, height: 175)
                                                    
                                                }
                                                VStack {
                                                    Text("Yearly Budget")
                                                        .font(.system(size: 16, weight: .bold))
                                                    if let totalBudget = totalBudgetAmount["yearly"]?[year] {
                                                        Text("LKR \(formatCurrency(value: totalBudget))")
                                                            .font(.system(size: 18, weight: .bold))
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                            }
                                            .frame(width: geometry.size.width, alignment: .center)
                                        }
                                    }
                                    else {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: 0, date: year, usedAmount: 0)
                                                .frame(width: 175, height: 175)
                                            VStack {
                                                Text("Yearly Budget")
                                                    .font(.system(size: 16, weight: .bold))
                                                Text("LKR \(formatCurrency(value: 0))")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(width: 300, alignment: .leading)
                                .offset(x: scrollOffset)
                                .animation(.easeInOut, value: scrollOffset)
                            }
                        }
                    }
                }
                .environment(\.isScrollEnabled, isScrollEnabled)
                .onTapGesture {
                    isScrollEnabled.toggle()
                }
                .coordinateSpace(name: "scroll")
                .onAppear() {
                    if selectedTab == .weekly || selectedTab == .monthly {
                        scrollToCurrentMonth()
                        date = months[currentPage]
                    } else if selectedTab == .yearly {
                        scrollToCurrentYear()
                        date = years[currentPage]
                    }
                }
            }
            
            Button {
                if selectedTab == .weekly || selectedTab == .monthly {
                    if currentPage < months.count - 1 {
                        scrollToPage(page: currentPage + 1, array: months)
                        date = months[currentPage]
                    }
                } else if selectedTab == .yearly {
                    if currentPage < years.count - 1 {
                        scrollToPage(page: currentPage + 1, array: years)
                        date = years[currentPage]
                    }
                }
            } label: {
                Image(systemName: "chevron.right.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color("ColorVividBlue"))
            }
            
        }
        .frame(height: 235)
        .padding()
        
    }
    
    private func scrollToPage(page: Int, array: [String]) {
        withAnimation {
            currentPage = min(max(page, 0), array.count - 1)
            scrollOffset = -CGFloat(currentPage) * 300
        }
    }
    
    func scrollToCurrentMonth() {
        if let currentMonthIndex = Calendar.current.dateComponents([.month], from: Date()).month {
            scrollToPage(page: currentMonthIndex - 1, array: months)
        }
    }
    func scrollToCurrentYear() {
        if let currentYearIndex = Calendar.current.dateComponents([.year], from: Date()).year,
           let index = years.firstIndex(of: "\(currentYearIndex)") {
            scrollToPage(page: index - 1, array: years)
        }
    }
}

struct OverallBudgetCategoryCardView: View {
    var primaryBackgroundColor: String
    var budgetCategoryName: String
    var amountAllocated: Double
    var amountSpent: Double
    var numberOfDaysSpent: Int
    var footerMessage: FooterMessage
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(primaryBackgroundColor))
            .frame(width: 400, height: 191)
            .overlay {
                VStack {
                    HStack(alignment: .center) {
                        HStack{
                            Circle()
                                .fill(Color(primaryBackgroundColor))
                                .frame(width: 14, height: 14)
                            Text(budgetCategoryName)
                                .font(.system(size: 16, weight: .semibold))
                        }.padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("ColorSnowWhite"))
                                
                            )
                        Spacer()
                        NavigationLink {
                            DetailBudgetView()
                        } label: {
                            Image(systemName: "arrow.forward.circle")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(Color("ColorWhite"))
                        }
                    }
                    VStack {
                        Text("Remaining LKR \(formatCurrency(value: calculateRemainingAmount(amountAllocated: amountAllocated, spent: amountSpent)))")
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        VStack {
                            GeometryReader { geometry in
                                ProgressView(value: calculateProgressBarValue(amountAllocated: amountAllocated, spent: amountSpent), total: 100)
                                    .progressViewStyle(RoundedRectProgressViewStyle(color: "ColorDarkBlue", width: geometry.size.width))
                                    .accentColor(Color("ColorFreshMintGreen"))
                            }.padding(.bottom, 10)
                            HStack {
                                HStack(alignment: .bottom, spacing: 0) {
                                    Text("\(formatCurrency(value: amountSpent)) of ")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                    Text("\(formatCurrency(value: amountAllocated))")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Text("\(numberOfDaysSpent) days")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 5)
                        HStack {
                            if(footerMessage.warning){
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(Color("ColorCottonCandy"))
                                    .font(.system(size: 24))
                                Text(footerMessage.message)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("ColorCottonCandy"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }else {
                                Text(footerMessage.message)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    Spacer()
                }.padding()
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

struct BudgetProgressView: View {
    var progressValue:Float
    var date: String
    var usedAmount: Double
    
    var body: some View {
        VStack {
            ProgressBarViewTwo(progress: progressValue, date: date, usedAmount: usedAmount)
        }
    }
}

struct ProgressBarViewTwo: View {
    var progress: Float
    var date: String
    var usedAmount: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .foregroundColor(Color("ColorPaleLavender"))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("ColorDarkBlue"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            VStack(spacing: 10) {
                Text("\(date)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("ColorVividBlue"))
                Text("LKR \(formatCurrency(value: usedAmount))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("ColorVividBlue"))
                Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("ColorVividBlue"))
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

