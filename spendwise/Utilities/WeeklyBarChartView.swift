//
//  WeeklyBarChart.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct WeeklyBarChartView: View {
    let days: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel()
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            HStack{
                Text("This Week Overview")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 180)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorJadeGreen"))
                    .frame(width: 12, height: 12)
                Text("Income")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .fontWeight(.semibold)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("ColorFireEngineRed"))
                    .frame(width: 12, height: 12)
                Text("Expense")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .medium))
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 10)
            VStack {
                HStack(spacing: 25){
                    ForEach(days, id: \.self) { day in
                        let fullday = fullDayName(day)
                        if let dayExpenses = homeViewModel.filteredExpensesByDay[fullday] {
                            let (totalExpenseAmount, totalIncomeAmount) = calculateTotalAmounts(for: dayExpenses)
                            let incomePercentage = Double(totalIncomeAmount) / Double(homeViewModel.overview.overallIncomeAmount)
                            let expensePercentage = Double(totalExpenseAmount) / Double(homeViewModel.overview.overallExpenseAmount)
                            let totalHeight = CGFloat(180)
                            let expenseBarHeight = CGFloat(expensePercentage * 90)
                            let incomeBarHeight = CGFloat(incomePercentage * 90)
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("ColorLightLavenderBlue"))
                                    .frame(width: 8, height: totalHeight)
                                    .overlay {
                                        VStack(spacing: 0) {
                                            VStack(spacing: 0) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color("ColorFireEngineRed"))
                                                    .frame(width: 8, height: expenseBarHeight > 90 ? 90 : expenseBarHeight)
                                                    .frame(maxHeight: 90, alignment: .bottom)
                                                    .padding(.bottom, 4)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color("ColorJadeGreen"))
                                                    .frame(width: 8, height: incomeBarHeight > 90 ? 90 : incomeBarHeight)
                                                    .frame(maxHeight: 90, alignment: .bottom)
                                            }
                                            
                                        }
                                    }
                                Text(day)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                        }
                        else {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("ColorLightLavenderBlue"))
                                    .frame(width: 8, height: 180)
                                    .overlay {
                                        VStack(spacing: 0) {
                                            VStack(spacing: 0) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color("ColorFireEngineRed"))
                                                    .frame(width: 8, height: 0)
                                                    .frame(maxHeight: 90, alignment: .bottom)
                                                    .padding(.bottom, 4)
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color("ColorJadeGreen"))
                                                    .frame(width: 8, height: 0)
                                                    .frame(maxHeight: 90, alignment: .bottom)
                                            }
                                            
                                        }
                                    }
                                Text(day)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("ColorSilverGray"), lineWidth: 3)
                    .frame(width: 385, height: 230)
            )
            
        }
        .padding()
        .onAppear {
//            printFilteredExpenses(homeViewModel.filteredExpensesByDay)
        }
    }
    
    func calculateTotalAmounts(for dayExpenses: [[TransactionCategory: Double]]) -> (Double, Double) {
        var totalExpenseAmount: Double = 0
        var totalIncomeAmount: Double = 0

        for expense in dayExpenses {
            if let expenseAmount = expense[.expense] {
                totalExpenseAmount += expenseAmount
            }
            if let incomeAmount = expense[.income] {
                totalIncomeAmount += incomeAmount
            }
        }

        return (totalExpenseAmount, totalIncomeAmount)
    }
    
    func fullDayName(_ shortenedDay: String) -> String {
        switch shortenedDay {
        case "Mon":
            return "monday"
        case "Tue":
            return "tuesday"
        case "Wed":
            return "wednesday"
        case "Thu":
            return "thursday"
        case "Fri":
            return "friday"
        case "Sat":
            return "saturday"
        case "Sun":
            return "sunday"
        default:
            return shortenedDay
        }
    }
    
    func printFilteredExpenses(_ filteredExpenses: [String: [[TransactionCategory: Double]]]) {
        for (day, expenses) in filteredExpenses {
            print("Day: \(day)")
            for expense in expenses {
                for (category, amount) in expense {
                    print("  Category: \(category), Amount: \(amount)")
                }
            }
        }
    }
}

struct WeeklyBarChart_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyBarChartView()
            .preferredColorScheme(.light)
    }
}
