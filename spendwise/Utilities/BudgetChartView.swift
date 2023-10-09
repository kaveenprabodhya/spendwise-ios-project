//
//  BudgetChartView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import SwiftUI

struct BudgetChartView: View {
    let filterBudgetArray: [Budget]
    var type: BudgetTypeOption
    
    var body: some View {
        VStack {
            switch type{
            case .monthly:
                HStack {
                    Text("My Monthly Budgets")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1])")
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal, 12)
            case .weekly:
                HStack {
                    Text("My Weekly Budgets")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1])")
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal, 12)
            case .yearly:
                HStack {
                    Text("My Yealry Budgets")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("\(String(Calendar.current.component(.year, from: Date())))")
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal, 12)
            }
            VStack {
                let filteredBudgets = filterBudgets(by: Date(), budgets: filterBudgetArray)
                let (totalAllocatedAmount, totalSpentAmount) = calculateTotals(for: type, in: filteredBudgets)
                CustomRoudedRectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color("ColorDarkBlue").opacity(0.88), Color("ColorTurquoiseBlue")]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading))
                    .frame(width: 390, height: 230)
                    .overlay {
                        VStack(spacing: 15) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading){
                                    Text("You have").foregroundColor(.white)
                                    HStack{
                                        Text("LKR \(formatCurrency(value: totalSpentAmount))")
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("left of \(formatCurrency(value: totalAllocatedAmount))")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                        
                                    }
                                }.padding(.top, 15)
                                ProgressView(value: totalSpentAmount, total: totalAllocatedAmount)
                                    .progressViewStyle(RoundedRectProgressViewStyle(color: Color("ColorFreshMintGreen"), width: 360))
                                    .accentColor(Color("ColorFreshMintGreen"))
                            }.frame(height: 74).padding(.top, 8).padding(.bottom, 5)
                            VStack(spacing: 0) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 0) {
                                        ForEach(filteredBudgets) { budget in
                                            if budget.budgetType.type == type {
                                                let progress = budget.currentAmountSpent / budget.allocatedAmount
                                                let progressVal = min(1.0, max(0.0, progress))
//                                                ForEach(budget.category) { category in
                                                    VStack {
                                                        CategoryProgressView(progressValue: Float(progressVal), categoryName: budget.category.name)
                                                    }
//                                                }
                                            }
                                        }
                                    }
                                }
                            }.padding(.horizontal, 10)
                        }
                    }
            }
        }.padding()
    }
    
    func calculateTotals(for type: BudgetTypeOption, in budgets: [Budget]) -> (totalAllocated: Double, totalSpent: Double) {
        let filteredBudgets = budgets.filter { $0.budgetType.type == type }
        let totalAllocated = filteredBudgets.reduce(0.0) { $0 + $1.allocatedAmount }
        let totalSpent = filteredBudgets.reduce(0.0) { $0 + $1.currentAmountSpent }
        return (totalAllocated, totalSpent)
    }
    
    func filterBudgets(by date: Date, budgets: [Budget]) -> [Budget] {
        return budgets.filter { budget in
            switch budget.budgetType.date {
            case .monthOnly(let month):
                return Calendar.current.component(.month, from: date) == month
            case .yearOnly(let year):
                return Calendar.current.component(.year, from: date) == year
            case .dateRange(let month, let start, let end):
                let currentMonth = Calendar.current.component(.month, from: date)
                return currentMonth == month && start <= end
            }
        }
    }
}

struct CategoryProgressView: View {
    var progressValue:Float
    var categoryName: String
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressBarViewOne(progress: self.progressValue)
                .frame(width: 75, height: 75)
                .padding(.bottom, 5)
            Text(categoryName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 10)
        .padding(.top, 8)
    }
}

struct ProgressBarViewOne: View {
    var progress: Float
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8.0)
                .foregroundColor(.white).opacity(0.8)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("ColorDarkBlue"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            Text(String(format: "%.0f %% used", min(self.progress, 1.0)*100.0))
                .font(.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 60)
                .fixedSize(horizontal: false, vertical: true)
                .bold()
        }
    }
}


struct CustomRoudedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let cornerRadius: CGFloat = 20.0
        
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct BudgetChartView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetChartView(filterBudgetArray: [
            Budget(
                id: UUID(), name: "",
                budgetType: BudgetType(type: .monthly, date: .monthOnly(10), limit: 2500),
                category:
                        BudgetCategory(
                            id: UUID(),
                            name: "Shopping",
                            primaryBackgroundColor: "ColorGoldenrod", iconName: "cart"
                        ),
                allocatedAmount: 400000.00,
                currentAmountSpent: 100000.00,
                numberOfDaysSpent: 8,
                footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: true),
                transactions: []
            ),
            Budget(
                id: UUID(), name: "",
                budgetType: BudgetType(type: .monthly, date: .monthOnly(11), limit: 2500),
                category:
                        BudgetCategory(
                            id: UUID(),
                            name: "Entertainment",
                            primaryBackgroundColor: "ColorGoldenrod", iconName: ""
                        ),
                allocatedAmount: 100000.00,
                currentAmountSpent: 10600.00,
                numberOfDaysSpent: 8,
                footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: true),
                transactions: []
            ),], type: .monthly)
    }
}
