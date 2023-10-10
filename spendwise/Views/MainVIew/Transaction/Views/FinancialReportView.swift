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
    @State var selectedGraphTab: ChartType = .pieChart
    
    var body: some View {
        VStack{
            HStack {
                SelectOptionView(
                    label: "",
                    selectedOption: $sortedByBudgetType,
                    sheetLabel: "Select an Option",
                    placeholderString: "Monthly", 
                    options: ["Monthly", "Weekly", "Yearly"],
                    iconColor: .black,
                    placeholderStringColor: .black,
                    placeholderStringFontSize: 18,
                    height: 44,
                    sheetHeight: 291,
                    cornerRadius: 40,
                    strokeColor: .black
                ){}
                    .frame(width: 116)
                Spacer()
                HStack(spacing: 0) {
                    Button {
                        selectedGraphTab = .lineChart
                    } label: {
                        UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                            .fill(selectedGraphTab == .lineChart ? Color("ColorVividBlue") : .white)
                            .frame(width: 48, height: 50)
                            .overlay {
                                if selectedGraphTab != .lineChart {
                                    UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0)
                                        .stroke(.gray, lineWidth: 2)
                                        .frame(width: 48, height: 48)
                                }
                                else {
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
                            .frame(width: 48, height: 50)
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
                        LineChartView(
                            dataLine1: [0.2, 0.6, 0.8, 0.4, 0.9, 0.5, 0.7],
                            dataLine2: [0.1, 0.5, 0.7, 0.3, 0.8, 0.4, 0.6],
                            months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
                            budgetAmounts: [15000, 18000, 16000, 20000, 17000, 19000, 21000]
                        )
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
                                            .foregroundStyle(selectedTab == .expense ? .white : .black)
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
                                            .foregroundStyle(selectedTab == .income ? .white : .black)
                                    }
                            }
                        }
                    }
            }
            HStack {
                SelectOptionView(
                    label: "",
                    selectedOption: $sortedByCategoryOrTxn,
                    sheetLabel: "Select an Option",
                    placeholderString: "Transaction",
                    options: ["Transaction", "Category"],
                    iconColor: .black,
                    placeholderStringColor: .black,
                    placeholderStringFontSize: 16,
                    height: 44,
                    sheetHeight: 281,
                    cornerRadius: 40,
                    strokeColor: .gray.opacity(0.5)
                ){}
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

struct PieChartView: View {
    let categoryData: [(category: String, amount: Double, color: Color)] = [
        ("Food", 500, .red),
        ("Housing", 800, .green),
        ("Entertainment", 300, .blue)
    ]
    var body: some View {
        VStack {
            HStack {
                VStack {
                    DonutChart(data: [300, 500, 200], colors: [.red, .green, .blue])
                        .frame(width: 250, height: 200)
                }
                VStack {
                    ForEach(categoryData, id: \.category) { item in
                        IndicatorView(color: item.color, label: item.category)
                    }
                }
            }
        }
    }
}

struct IndicatorView: View {
    let color: Color
    let label: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            
            Text(label)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 5)
    }
}

struct LineChartView: View {
    let dataLine1: [CGFloat] // Data points for the first line
    let dataLine2: [CGFloat] // Data points for the second line
    let months: [String] // Labels for the x-axis (months)
    let budgetAmounts: [Int]

    var body: some View {
        GeometryReader { geometry in
            let maxYValue = max(dataLine1.max() ?? 1, dataLine2.max() ?? 1)
            let stepWidth = geometry.size.width / CGFloat(months.count - 1)
            let stepHeight = geometry.size.height / maxYValue
            
            ZStack {
                // Draw the first line
                Path { path in
                    for (index, dataPoint) in dataLine1.enumerated() {
                        let x = stepWidth * CGFloat(index)
                        let y = geometry.size.height - stepHeight * dataPoint
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
                
                // Draw the second line
                Path { path in
                    for (index, dataPoint) in dataLine2.enumerated() {
                        let x = stepWidth * CGFloat(index)
                        let y = geometry.size.height - stepHeight * dataPoint
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.green, lineWidth: 2)
                
                // Add x-axis labels (months)
                ForEach(0..<months.count, id: \.self) { index in
                    Text(months[index])
                        .font(.caption)
                        .position(x: stepWidth * CGFloat(index), y: geometry.size.height + 10)
                }
                
                // Add y-axis labels (amounts)
                ForEach(0..<budgetAmounts.count, id: \.self) { index in
                    Text("\(budgetAmounts[index])")
                        .font(.caption)
                        .position(x: stepWidth * CGFloat(index), y: geometry.size.height + 26)
                }
                
                // Add circles at data points for the first line
                ForEach(0..<dataLine1.count, id: \.self) { index in
                    let x = stepWidth * CGFloat(index)
                    let y = geometry.size.height - stepHeight * dataLine1[index]
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: y)
                }
                
                // Add circles at data points for the second line
                ForEach(0..<dataLine2.count, id: \.self) { index in
                    let x = stepWidth * CGFloat(index)
                    let y = geometry.size.height - stepHeight * dataLine2[index]
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: y)
                }
            }
        }
        .padding(50) // Apply overall padding of 15 points
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(
            dataLine1: [0.2, 0.6, 0.8, 0.4, 0.9, 0.5, 0.7],
            dataLine2: [0.1, 0.5, 0.7, 0.3, 0.8, 0.4, 0.6],
            months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
            budgetAmounts: [15000, 18000, 16000, 20000, 17000, 19000, 21000]
        )
        .frame(height: 200)
    }
}

struct DonutChart: View {
    var data: [Double]
    var colors: [Color]

    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let total = data.reduce(0, +)
            
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    let startAngle: Angle = index == 0 ? .zero : Angle(degrees: data[0..<index].reduce(0, +) / total * 360)
                    let endAngle: Angle = Angle(degrees: data[0..<index + 1].reduce(0, +) / total * 360)
                    let path = Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    }
                    path.fill(colors[index])
                }
                Circle()
                    .fill(Color.white)
                    .frame(width: radius * 1.3, height: radius * 1.3)
            }
        }
    }
}

struct DonutChartView_Previews: PreviewProvider {
    static var previews: some View {
        let data: [Double] = [30, 50, 20] // Example data
        let colors: [Color] = [.red, .green, .blue] // Example colors
        
        return DonutChart(data: data, colors: colors)
            .frame(width: 200, height: 200)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
