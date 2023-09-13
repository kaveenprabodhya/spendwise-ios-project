//
//  BudgetChartView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-08.
//

import SwiftUI

struct BudgetChartView: View {
    @State var totalBudget: Double = 100000.00
    @State var totalSpendFromBudget: Double = 29000.00
    @State var progressValue: Float = 0.3
    
    let budgetArray: [Budget] = [
        Budget(
            id: "qwerty1234",
            category:
                [
                    BudgetCategory(
                        id: "1",
                        name: "Shopping",
                        primaryBackgroundColor: "ColorGoldenrod"
                    )
                ],
            allocatedAmount: 300000.00,
            currentAmountSpent: 100000.00,
            numberOfDaysSpent: 8,
            footerMessage: FooterMessage(message: "You’ve exceed the limit!", warning: true)
        )
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("My Budgets")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            VStack {
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
                                        Text("LKR \(formatCurrency(value: totalSpendFromBudget))")
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("left of \(formatCurrency(value: totalBudget))")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                        
                                    }
                                }.padding(.top, 15)
                                ProgressView(value: 90, total: 100)
                                    .progressViewStyle(RoundedRectProgressViewStyle(color: "ColorFreshMintGreen", width: 360))
                                    .accentColor(Color("ColorFreshMintGreen"))
                            }.frame(height: 74).padding(.top, 8).padding(.bottom, 5)
                            VStack(spacing: 0) {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 0) {
                                        ForEach(budgetArray) { budget in
                                            ForEach(budget.category) { category in
                                                VStack {
                                                    CategoryProgressView(progressValue: progressValue, categoryName: category.name)
                                                }
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
}

struct CategoryProgressView: View {
    @State var progressValue:Float
    @State var categoryName: String
    var body: some View {
        VStack(spacing: 0) {
            ProgressBarViewOne(progress: self.$progressValue)
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
    @Binding var progress: Float
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

struct BudgetChartView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetChartView()
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
