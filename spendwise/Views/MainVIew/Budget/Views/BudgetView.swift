//
//  BudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct BudgetView: View {
    @State private var selectedTab: BudgetTypeOption = .weekly
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel()
    
    var yearlyBudgets: [Budget] {
        viewModel.budgetArray.filter { $0.budgetType.type == .yearly }
    }
    
    var monthlyBudgets: [Budget] {
        viewModel.budgetArray.filter { $0.budgetType.type == .monthly }
    }
    
    var weeklyBudgets: [Budget] {
        viewModel.budgetArray.filter { $0.budgetType.type == .weekly }
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab){
                WeeklyPageTabView(selectedTab: $selectedTab, budgets: weeklyBudgets)
                    .tag(BudgetTypeOption.weekly)
                MonthlyPageTabView(selectedTab: $selectedTab, budgets: monthlyBudgets)
                    .tag(BudgetTypeOption.monthly)
                YearlyPageTabView(selectedTab: $selectedTab, budgets: yearlyBudgets)
                    .tag(BudgetTypeOption.yearly)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(.clear)
                    .overlay(alignment: .center) {
                        HStack(spacing: 25) {
                            Button {
                                self.selectedTab = .weekly
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.selectedTab == .weekly ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                    .frame(width: 108, height: 46)
                                    .overlay {
                                        Text("Weekly")
                                            .fontWeight(.semibold)
                                            .foregroundColor(self.selectedTab == .weekly ? .white : .black)
                                    }
                            }
                            Button {
                                self.selectedTab = .monthly
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.selectedTab == .monthly ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                    .frame(width: 108, height: 46)
                                    .overlay {
                                        Text("Monthly")
                                            .fontWeight(.semibold)
                                            .foregroundColor(self.selectedTab == .monthly ? .white : .black)
                                    }
                            }
                            Button {
                                self.selectedTab = .yearly
                            } label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.selectedTab == .yearly ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                    .frame(width: 108, height: 46)
                                    .overlay {
                                        Text("Yearly")
                                            .fontWeight(.semibold)
                                            .foregroundColor(self.selectedTab == .yearly ? .white : .black)
                                    }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width, height: 65)
                        .background(.white.opacity(0.3))
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

struct WeeklyPageTabView: View {
    @Binding var selectedTab: BudgetTypeOption
    var budgets: [Budget]
    var body: some View {
        BottomBudgetOverView(selectedTab: $selectedTab, budgets: self.budgets)
    }
}

struct YearlyPageTabView: View {
    @Binding var selectedTab: BudgetTypeOption
    var budgets: [Budget]
    var body: some View {
        BottomBudgetOverView(selectedTab: $selectedTab, budgets: self.budgets)
    }
}

struct MonthlyPageTabView: View {
    @Binding var selectedTab: BudgetTypeOption
    var budgets: [Budget]
    var body: some View {
        BottomBudgetOverView(selectedTab: $selectedTab, budgets: self.budgets)
    }
}


struct BottomBudgetOverView: View {
    var heightOfSheet: CGFloat = 672
    @Binding var selectedTab: BudgetTypeOption
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
                            BottomBudgetSheet(selectedTab: $selectedTab, sheetHeight: heightOfSheet, budgetArray: budgets)
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
    @State var limitPerDay: Double = 0
    @Binding var selectedTab: BudgetTypeOption
    
    var spentAmountForLast7Days: Double = 0
    var sheetHeight: CGFloat
    
    var budgetArray: [Budget]
    
    var allocatedtotalBudgetAmount: Double {
        budgetArray.reduce(0) { (result, budget) in
            result + budget.allocatedAmount
        }
    }
    
    var totalAmountSpent: Double {
        budgetArray.reduce(0) { (result, budget) in
            result + budget.currentAmountSpent
        }
    }
    
    var totalAmountRemaining: Double {
        allocatedtotalBudgetAmount - totalAmountSpent
    }
    
    var progressValue: Float {
        let totalBudget = Float(allocatedtotalBudgetAmount)
        let spent = Float(totalAmountSpent)
        if totalBudget == 0 {
            return 0
        }
        let progress = spent / totalBudget
        return min(1.0, max(0.0, progress))
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
                        totalBudgetAmount: allocatedtotalBudgetAmount,
                        progressValue: progressValue,
                        usedAmount: totalAmountSpent,
                        selectedTab: $selectedTab,
                        budgetArray: budgetArray
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
                        totalBudgetAmount: allocatedtotalBudgetAmount,
                        progressValue: progressValue,
                        usedAmount: totalAmountSpent,
                        selectedTab: $selectedTab,
                        budgetArray: budgetArray
                    )
                    VStack(spacing : 0) {
                        if !spentAmountForLast7Days.isNaN {
                            HStack {
                                Text("You’ve spent")
                                    .font(.system(size: 14, weight: .medium))
                                Text("LKR \(formatCurrency(value: spentAmountForLast7Days))")
                                    .foregroundColor(Color("ColorVividBlue"))
                                    .font(.system(size: 16, weight: .bold))
                                
                                Text("for the past 7 days")
                                    .font(.system(size: 14, weight: .medium))
                            }.padding()
                        }
                        HStack {
                            Text("What’s left to spend").font(.system(size: 14, weight: .medium))
                            Spacer()
                            Text("\(formatCurrency(value: totalAmountRemaining))").font(.system(size: 16, weight: .bold))
                        }.padding(.horizontal, 20).padding(.bottom, 4)
                        HStack {
                            Text("Spend Limit per Day").font(.system(size: 14, weight: .medium))
                            Spacer()
                            Text("\(formatCurrency(value: limitPerDay))").font(.system(size: 16, weight: .bold))
                        }.padding(.horizontal, 20).padding(.bottom, 4)
                    }.padding(.bottom, 20)
                    GeometryReader { geometry in
                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(budgetArray) { budget in
                                    ForEach(budget.category) { category in
                                        OverallBudgetCategoryCardView(
                                            primaryBackgroundColor: category.primaryBackgroundColor, budgetCategoryName: category.name, amountAllocated: budget.allocatedAmount, amountSpent: budget.currentAmountSpent, numberOfDaysSpent: budget.numberOfDaysSpent, footerMessage: budget.footerMessage
                                        )
                                    }
                                }
                            }
                            
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
        }
    }
}

struct BudgetOverView: View {
    var totalBudgetAmount: Double
    @State var progressValue: Float
    @State var usedAmount: Double
    @State private var scrollOffset: CGFloat = 0
    @State private var currentPage = 0
    @State private var isScrollEnabled = false
    @Binding var selectedTab: BudgetTypeOption
    
    var budgetArray: [Budget]
    var months:[String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var years: [String] {
        (0..<10).map { String(currentYear + $0) }
    }
    
    func getDateOptionAndLabel(for budgets: [Budget]) -> (BudgetDateOption, String) {
        let dateOption = budgets[0].budgetType.date

        switch dateOption {
        case .monthOnly(let month):
            let label = Calendar.current.monthSymbols[month - 1]
            return (.monthOnly(month), label)
        case .yearOnly(let year):
            let label = "\(year)"
            return (.yearOnly(year), label)
        case .dateRange(let month, let startDate, let endDate):
            let monthString = Calendar.current.monthSymbols[month - 1] // Adjust for 0-based indexing
            let label = "\(monthString), \(startDate)-\(endDate)"
            return (.dateRange(month, startDate, endDate), label)
        }
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
                    scrollToPage(page: currentPage - 1, array: months)
                } else if selectedTab == .yearly {
                    scrollToPage(page: currentPage - 1, array: years)
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
                                let (_, label) = getDateOptionAndLabel(for: budgetArray)
                                VStack {
                                    if label == month {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: $progressValue, date: label, usedAmount: $usedAmount)
                                                .frame(width: 175, height: 175)
                                            VStack {
                                                Text("Monthly Budget")
                                                    .font(.system(size: 16, weight: .bold))
                                                Text("LKR \(formatCurrency(value: totalBudgetAmount))")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                    } else {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: .constant(0), date: month, usedAmount: .constant(0))
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
                        else if selectedTab == .weekly {
                            ForEach(months, id: \.self) { month in
                                let (_, label) = getDateOptionAndLabel(for: budgetArray)
                                let monthExtracted = extractMonth(from: label, with: "([A-Za-z]+),")
                                VStack {
                                    if monthExtracted == month {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: $progressValue, date: label, usedAmount: $usedAmount)
                                                .frame(width: 175, height: 175)
                                            VStack {
                                                Text("Weekly Budget")
                                                    .font(.system(size: 16, weight: .bold))
                                                Text("LKR \(formatCurrency(value: totalBudgetAmount))")
                                                    .font(.system(size: 18, weight: .bold))
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                    } else {
                                        VStack(spacing: 15) {
                                            BudgetProgressView(progressValue: .constant(0), date: month, usedAmount: .constant(0))
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
                        else if selectedTab == .yearly {
                            ForEach(years, id: \.self) { year in
                                let (_, label) = getDateOptionAndLabel(for: budgetArray)
                                VStack {
                                    if label == year {
                                    VStack(spacing: 15) {
                                        BudgetProgressView(progressValue: $progressValue, date: label, usedAmount: $usedAmount)
                                            .frame(width: 175, height: 175)
                                        VStack {
                                            Text("Yearly Budget")
                                                .font(.system(size: 16, weight: .bold))
                                            Text("LKR \(formatCurrency(value: totalBudgetAmount))")
                                                .font(.system(size: 18, weight: .bold))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .frame(width: geometry.size.width, alignment: .center)
                                }
                                    else {
                                       VStack(spacing: 15) {
                                           BudgetProgressView(progressValue: .constant(0), date: year, usedAmount: .constant(0))
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
                    } else {
                        scrollToCurrentYear()
                    }
                }
            }
            
            Button {
                if selectedTab == .weekly || selectedTab == .monthly {
                    scrollToPage(page: currentPage + 1, array: months)
                } else if selectedTab == .yearly {
                    scrollToPage(page: currentPage + 1, array: years)
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
    @Binding var progressValue:Float
     var date: String
    @Binding var usedAmount: Double
    
    var body: some View {
        VStack {
            ProgressBarViewTwo(progress: $progressValue, date: date, usedAmount: $usedAmount)
        }
    }
}

struct ProgressBarViewTwo: View {
    @Binding var progress: Float
     var date: String
    @Binding var usedAmount: Double
    
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

