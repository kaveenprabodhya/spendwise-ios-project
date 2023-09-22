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
    @State var date: String = ""
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel()
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab){
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
                    .tag(BudgetTypeOption.weekly)
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
                    .tag(BudgetTypeOption.monthly)
                PageTabView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
                    .tag(BudgetTypeOption.yearly)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(.clear)
                    .overlay(alignment: .center) {
                        TabButtons(selectedTab: $selectedTab, date: $date)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(height: 95)
            }
        }
        .onAppear{
            viewModel.fetchData()
            if selectedTab == .monthly || selectedTab == .weekly{
                date = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
            } else if selectedTab == .yearly {
                date = String(Calendar.current.component(.year, from: Date()))
            }
        }
    }
}

struct TabButtons: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var date:String
    
    var body: some View {
        HStack(spacing: 25) {
            Button(action: {
                withAnimation {
                    self.selectedTab = .weekly
                    date = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
                }
            }) {
                TabButton(label: "Weekly", isSelected: selectedTab == .weekly)
            }
            Button(action: {
                withAnimation {
                    self.selectedTab = .monthly
                    date = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
                }
            }) {
                TabButton(label: "Monthly", isSelected: selectedTab == .monthly)
            }
            Button(action: {
                withAnimation {
                    self.selectedTab = .yearly
                    date = String(Calendar.current.component(.year, from: Date()))
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
    @Binding var date: String
    @ObservedObject var viewModel: BudgetViewModel
    
    func printBudgets(budget: [Budget]) {
        for budget in budget {
            print(budget.budgetType.type)
            print(budget.category[0].name)
            print(budget.allocatedAmount)
        }
    }
    
    var body: some View {
        if selectedTab == .monthly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
                .onAppear{
                    let _: () = printBudgets(budget: viewModel.monthlyBudgets)
                    date = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
                }
        } else if selectedTab == .weekly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
        } else if selectedTab == .yearly {
            BottomBudgetSheetOverView(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, viewModel: viewModel)
        }
    }
}

struct BottomBudgetSheetOverView: View {
    var heightOfSheet: CGFloat = 672
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    @Binding var date: String
    @ObservedObject var viewModel: BudgetViewModel
    
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
                            BottomBudgetSheet(selectedTab: $selectedTab, currentPage: $currentPage, date: $date, sheetHeight: heightOfSheet,viewModel: viewModel)
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
    @Binding var currentPage: Int
    @Binding var date: String
    var sheetHeight: CGFloat
    @ObservedObject var viewModel: BudgetViewModel
    
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
            if viewModel.budgetArray.isEmpty {
                VStack(spacing: 0) {
                    BudgetOverView(
                        selectedTab: $selectedTab,
                        currentPage: $currentPage,
                        date: $date,
                        viewModel: viewModel
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
                    VStack(spacing: 0) {
                        BudgetOverView(
                            selectedTab: $selectedTab,
                            currentPage: $currentPage,
                            date: $date,
                            viewModel: viewModel
                        )
                        .padding(.vertical, 15)
                    }
                    VStack(spacing : 0) {
                        let amountSpent = viewModel.amountSpentForLast7Days
                        if !amountSpent.isEmpty {
                            ForEach(amountSpent) { spend in
                                if spend.budgetType == .monthly {
                                    if spend.monthOrYear == date {
                                        HStack {
                                            Text("You’ve spent")
                                                .font(.system(size: 14, weight: .medium))
                                            Text("LKR \(formatCurrency(value: spend.amount))")
                                                .foregroundColor(Color("ColorVividBlue"))
                                                .font(.system(size: 16, weight: .bold))
                                            Text("for the past \(spend.daysCount) days")
                                                .font(.system(size: 14, weight: .medium))
                                        }.padding(.top, 0).padding(.bottom, 8).offset(y: -14)
                                    }
                                }
                            }
                        }
                        HStack {
                            Text("What’s left to spend").font(.system(size: 14, weight: .medium))
                            Spacer()
                            if selectedTab == .monthly {
                                if let leftToSpendAmount = viewModel.totalAmountRemainingByMonth["monthly"]?[date] {
                                    Text("\(formatCurrency(value: leftToSpendAmount))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            else if selectedTab == .weekly {
                                if let leftToSpendAmount = viewModel.totalAmountRemainingByMonth["weekly"]?.compactMap({ $0.key.contains(date) ? $0.value : nil }).first {
                                    Text("\(formatCurrency(value: leftToSpendAmount))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            else if selectedTab == .yearly {
                                if let leftToSpendAmount = viewModel.totalAmountRemainingByMonth["yearly"]?[date] {
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
                                if let limit = viewModel.limitForBudgetType["monthly"]?[date] {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            if selectedTab == .weekly {
                                if let limit = viewModel.limitForBudgetType["weekly"]?.compactMap({ $0.key.contains(date) ? $0.value : nil }).first  {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                    Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                                }
                            }
                            if selectedTab == .yearly {
                                if let limit = viewModel.limitForBudgetType["yearly"]?[date] {
                                    Text("\(formatCurrency(value: limit))").font(.system(size: 16, weight: .bold))
                                }
                                else {
                                   Text("\(formatCurrency(value: 0))").font(.system(size: 16, weight: .bold))
                               }
                            }

                        }.padding(.horizontal, 20).padding(.bottom, 4)
                    }.padding(.top, 0).padding(.bottom, 10)
                        VStack {
                            ScrollView(showsIndicators: false) {
                                VStack {
                                    if selectedTab == .monthly {
                                        let filteredBudgets = viewModel.monthlyBudgets.filter { budget in
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
                                        let filteredBudgets = viewModel.weeklyBudgets.filter { budget in
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
                                        let filteredBudgets = viewModel.yearlyBudgets.filter { budget in
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.padding(.vertical, 5)
                }
                .onAppear {
                    viewModel.fetchAmountSpentForLast7Days()
                }
            }
        }
    }
}

struct BudgetOverView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var isScrollEnabled = false
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    @Binding var date: String
    @ObservedObject var viewModel: BudgetViewModel
    
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var years: [String] {
        (0..<10).map { String(currentYear + $0) }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                if selectedTab == .weekly || selectedTab == .monthly {
                    if currentPage > 0 {
                        scrollToPage(page: currentPage - 1, array: months)
                        date = months[currentPage]
                    }
                } else if selectedTab == .yearly {
                    if currentPage > 0 {
                        scrollToPage(page: currentPage - 1, array: years)
                        date = years[currentPage]
                    }
                }
            } label: {
                Image(systemName: "chevron.left.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color("ColorVividBlue"))
            }
                HStack(spacing: 0){
                    if selectedTab == .monthly {
                        TabView(selection: $currentPage) {
                            ForEach(months.indices, id: \.self) { index in
                                MonthlyBudgetOverview(selectedTab: $selectedTab, currentPage: $currentPage, month: months[index], viewModel: viewModel)
                                    .tag(index)
                            }
                        }
                        .frame(height: 235)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onAppear {
                              UIScrollView.appearance().isScrollEnabled = false
                        }
                    }
                    if selectedTab == .weekly {
                        TabView(selection: $currentPage) {
                            ForEach(months.indices, id: \.self) { index in
                               WeeklyBudgetOverview(selectedTab: $selectedTab, currentPage: $currentPage, month: months[index], viewModel: viewModel)
                                    .tag(index)
                            }
                        }
                        .frame(height: 280)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onAppear {
                              UIScrollView.appearance().isScrollEnabled = false
                        }
                    }
                    if selectedTab == .yearly {
                        TabView(selection: $currentPage) {
                            ForEach(years.indices, id: \.self) { index in
                               YearlyBudgetOverview(selectedTab: $selectedTab, currentPage: $currentPage, year: years[index], viewModel: viewModel)
                                    .tag(index)
                            }
                        }
                        .frame(height: 235)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onAppear {
                              UIScrollView.appearance().isScrollEnabled = false
                        }
                    }
                }
                .onAppear() {
                    withAnimation {
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
        .padding()
    }
    
    private func scrollToPage(page: Int, array: [String]) {
            currentPage = min(max(page, 0), array.count - 1)
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

struct WeeklyBudgetOverview: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    var month: String
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let (_, label) = viewModel.getDateOptionAndLabel(selectedTab: .weekly, for: month, budgets: viewModel.budgetByWeek) {
                if let monthExtracted = viewModel.extractMonth(from: label, with: "([A-Za-z]+),") {
                    if monthExtracted == month {
                        VStack(spacing: 0) {
                            if let weeklyProgress = viewModel.progressValueByMonth["weekly"]?[label], let weeklySpentAmount = viewModel.totalAmountSpentByMonth["weekly"]?[label] {
                                VStack(spacing: 0) {
                                    BudgetProgressView(
                                        progressValue: weeklyProgress,
                                        date: label,
                                        usedAmount: weeklySpentAmount,
                                        selectedTab: $selectedTab,
                                        viewModel: viewModel
                                    )
                                }.padding(.bottom, 8)
                            }
                            VStack(spacing: 0) {
                                Text("Weekly Budget")
                                    .font(.system(size: 16, weight: .bold)).padding(5)
                                if let totalBudget = viewModel.allocatedTotalBudgetAmountByMonth["weekly"]?[label] {
                                    Text("LKR \(formatCurrency(value: totalBudget))")
                                        .font(.system(size: 18, weight: .bold))
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                }
            }
            else {
                VStack(spacing: 0) {
                    BudgetProgressView(
                        progressValue: 0,
                        date: month,
                        usedAmount: 0,
                        selectedTab: $selectedTab,
                        viewModel: viewModel
                    ).padding(.bottom, 12)
                    VStack(spacing: 0) {
                        Text("Weekly Budget")
                            .font(.system(size: 16, weight: .semibold))
                        Text("LKR \(formatCurrency(value: 0))")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
}

struct MonthlyBudgetOverview: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    var month: String
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let (_, label) = viewModel.getDateOptionAndLabel(selectedTab: .monthly, for: month, budgets: viewModel.budgetByMonth) {
                if label == month {
                    VStack(spacing: 15) {
                        if let monthlyProgress = viewModel.progressValueByMonth["monthly"]?[label], let monthlySpentAmount = viewModel.totalAmountSpentByMonth ["monthly"]?[label] {
                            BudgetProgressView(progressValue: monthlyProgress, date: label, usedAmount: monthlySpentAmount, selectedTab: $selectedTab, viewModel: viewModel)
                                .frame(width: 175, height: 175)
                        }
                        VStack {
                            Text("Monthly Budget")
                                .font(.system(size: 16, weight: .bold))
                            if let totalBudget = viewModel.allocatedTotalBudgetAmountByMonth["monthly"]?[month] {
                                Text("LKR \(formatCurrency(value: totalBudget))")
                                    .font(.system(size: 18, weight: .bold))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            } else {
                VStack(spacing: 15) {
                    BudgetProgressView(progressValue: 0, date: month, usedAmount: 0, selectedTab: $selectedTab, viewModel: viewModel)
                        .frame(width: 175, height: 175)
                    VStack {
                        Text("Monthly Budget")
                            .font(.system(size: 16, weight: .bold))
                        Text("LKR \(formatCurrency(value: 0))")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

struct YearlyBudgetOverview: View {
    @Binding var selectedTab: BudgetTypeOption
    @Binding var currentPage: Int
    var year: String
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack {
            if let (_, label) = viewModel.getDateOptionAndLabel(selectedTab: .yearly, for: year, budgets: viewModel.budgetByYear) {
                if label == year {
                    VStack(spacing: 15) {
                        if let yearlyProgress = viewModel.progressValueByMonth["yearly"]?[year], let yearlySpentAmount = viewModel.totalAmountSpentByMonth["yearly"]?[year] {
                            BudgetProgressView(progressValue: yearlyProgress, date: label, usedAmount: yearlySpentAmount, selectedTab: $selectedTab, viewModel: viewModel)
                                .frame(width: 175, height: 175)
                            
                        }
                        VStack {
                            Text("Yearly Budget")
                                .font(.system(size: 16, weight: .bold))
                            if let totalBudget = viewModel.allocatedTotalBudgetAmountByMonth["yearly"]?[year] {
                                Text("LKR \(formatCurrency(value: totalBudget))")
                                    .font(.system(size: 18, weight: .bold))
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            else {
                VStack(spacing: 15) {
                    BudgetProgressView(progressValue: 0, date: year, usedAmount: 0, selectedTab: $selectedTab, viewModel: viewModel)
                        .frame(width: 175, height: 175)
                    VStack {
                        Text("Yearly Budget")
                            .font(.system(size: 16, weight: .bold))
                        Text("LKR \(formatCurrency(value: 0))")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

struct BudgetProgressView: View {
    var progressValue:Float
    var date: String
    var usedAmount: Double
    @Binding var selectedTab: BudgetTypeOption
    @ObservedObject var viewModel: BudgetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if selectedTab == .monthly || selectedTab == .yearly {
                ProgressBarViewTwo(progress: progressValue, date: date, usedAmount: usedAmount)
            } else if selectedTab == .weekly {
                ProgressViewThree(date: date, usedAmount: usedAmount, viewModel: viewModel)
            }
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
        }.padding(.vertical, 5)
    }
}

struct ProgressViewThree: View {
    var date: String
    var usedAmount: Double
    @ObservedObject var viewModel: BudgetViewModel
    
    func extractDateRange(from inputString: String) -> [Int]? {
        let regexPattern = #"\b(\d{1,2}-\d{1,2})\b"#
        print(regexPattern)
        if let range = inputString.range(of: regexPattern, options: .regularExpression) {
            let extractedRange = inputString[range]
            let components = extractedRange.components(separatedBy: "-")
            if components.count == 2, let start = Int(components[0]), let end = Int(components[1]) {
                return [start, end]
            }
        }
        
        return nil
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let monthExtracted = viewModel.extractMonth(from: date, with: "([A-Za-z]+),") {
                if let extractedDateRange = extractDateRange(from: date) {
                    CalenderView(month: monthExtracted, dateRange: extractedDateRange)
                }
//                Text("\(extractDateRange(from: date)?.description ?? "nil")")
            } else {
                CalenderView(month: date)
            }
        }
    }
}

struct CalenderView: View {
    var month: String
    var dateRange: [Int]?
    
    init(month: String) {
        self.month = month
    }
    
    init(month: String, dateRange: [Int]?) {
        self.month = month
        self.dateRange = dateRange.map(expandDateRange)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(month)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("ColorVividBlue"))
                .padding(.bottom, 12)
            let (daysInMonth) = calculateCalendarData(for: month)
            VStack(alignment: .center, spacing: 0) {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(28), spacing: 0), count: 7), spacing: 0) {
                    ForEach(daysInMonth.indices, id: \.self) { index in
                        if daysInMonth[index].isEmpty {
                            Rectangle()
                                .fill(.clear)
                                .padding(2)
                        } else {
                            Rectangle()
                                .fill(.clear)
                                .overlay {
                                    HStack {
                                        Text("\(daysInMonth[index])")
                                            .font(.system(size: 16))
                                            .foregroundColor(isInDateRange(daysInMonth[index]) ? .white : .black)
                                    }.frame(maxWidth: .infinity, alignment: .center)
                                }
                                .background(isInDateRange(daysInMonth[index]) ? Color("ColorVividBlue") : .white)
                                .frame(width: 28, height: 28, alignment: .center)
                                .padding(2)
                        }
                    }
                }
            }
        }
    }
    
    func expandDateRange(_ range: [Int]) -> [Int] {
            var expandedRange: [Int] = []
            for i in range.first!...range.last! {
                expandedRange.append(i)
            }
            return expandedRange
        }
    
    func isInDateRange(_ day: String) -> Bool {
        if !day.isEmpty {
            if let dateRange = dateRange {
                //                    return dateRange.contains(Int(day))
                if let dayNumber = Int(day) {
                    return dateRange.contains(dayNumber)
                }
            }
        }
            return false
        }
    
    func calculateCalendarData(for date: String) -> ([String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let dateComponents = DateComponents(year: year, month: month, day: 1)
            let startDate = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: startDate)

            let firstDayWeekday = calendar.component(.weekday, from: startDate) - 1
            let daySymbols = Calendar.current.veryShortStandaloneWeekdaySymbols
            var daysInMonth: [String] = daySymbols
            if firstDayWeekday > 0 {
                daysInMonth.append(contentsOf: Array(repeating: "", count: firstDayWeekday))
            }
            if let range = range {
                daysInMonth.append(contentsOf: (1..<range.count + 1).map { "\($0)" })
            }
            
            for day in daysInMonth {
                print(day)
            }
            
            return (daysInMonth)
        }
        
        return ([])
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

