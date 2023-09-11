//
//  BudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct BudgetView: View {
    @State var index = 2
    
    var body: some View {
        TabView(selection: $index){
            WeeklyPageTabView()
                .tag(1)
            MonthlyPageTabView()
                .tag(2)
            YearlyPageTabView()
                .tag(3)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.bottom)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(.clear)
                .overlay(alignment: .center) {
                    HStack(spacing: 25) {
                        Button {
                            self.index = 1
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(self.index == 1 ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                .frame(width: 108, height: 46)
                                .overlay {
                                    Text("Weekly")
                                        .fontWeight(.semibold)
                                        .foregroundColor(self.index == 1 ? .white : .black)
                                }
                        }
                        Button {
                            self.index = 2
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(self.index == 2 ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                .frame(width: 108, height: 46)
                                .overlay {
                                    Text("Monthly")
                                        .fontWeight(.semibold)
                                        .foregroundColor(self.index == 2 ? .white : .black)
                                }
                        }
                        Button {
                            self.index = 3
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(self.index == 3 ? Color("ColorVividBlue") : Color("ColorPaleBlueGray"))
                                .frame(width: 108, height: 46)
                                .overlay {
                                    Text("Yearly")
                                        .fontWeight(.semibold)
                                        .foregroundColor(self.index == 3 ? .white : .black)
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
}

struct WeeklyPageTabView: View {
    var body: some View {
        BottomBudgetOverView()
    }
}

struct YearlyPageTabView: View {
    var body: some View {
        BottomBudgetOverView()
    }
}

struct MonthlyPageTabView: View {
    var body: some View {
        BottomBudgetOverView()
    }
}


struct BottomBudgetOverView: View {
    
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
                            BottomBudgetSheet(sheetHeight: 752)
                        }
                        .frame(width: geometry.size.width, height: 752)
                        .frame(maxHeight: .infinity, alignment: .bottom )
                    }
                })
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct BottomBudgetSheet: View {
    @State var progressValue:Float = 0
    @State var date: String = "Month"
    @State var usedAmount: Double = 0.00
    @State var totalBudgetAmount: Double = 0.00
    
    var spentAmountForLast7Days: Double = 300000.00
    var leftToSpend: Int = 17500
    var limitPerDay: Int = 3000
    var sheetHeight: CGFloat
    
    
    var budgetArray: [BudgetCategory] = [BudgetCategory(id: "qwerty1234", name: "Shopping", allocatedAmount: 300000.00, currentAmountSpent: 100000.00)]
    
    var body: some View{
        UnevenRoundedRectangleViewShape(topLeftRadius: 30,topRightRadius: 30, bottomLeftRadius: 0, bottomRightRadius: 0)
            .fill(.white)
            .frame(height: sheetHeight)
            .overlay {
                if budgetArray.isEmpty {
                    VStack {
                        BudgetOverView(totalBudgetAmount: self.$totalBudgetAmount, progressValue: self.$progressValue, date: self.$date, usedAmount: self.$usedAmount)
                        VStack {
                            Image("budget-empty-screen")
                                .resizable()
                                .scaledToFit()
                        }.overlay {
                            VStack {
                                Text(
                                     """
                                     Looks Like, You don’t have a budget.
                                     Let’s make one so you in control.
                                     """
                                )
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .medium))
                                Spacer()
                            }.padding()
                        }
                        Spacer()
                    }
                }
                else {
                    VStack {
                        BudgetOverView(totalBudgetAmount: self.$totalBudgetAmount, progressValue: self.$progressValue, date: self.$date, usedAmount: self.$usedAmount)
                        VStack {
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
                                Text("\(leftToSpend)").font(.system(size: 16, weight: .bold))
                            }.padding(.horizontal, 10).padding(.bottom, 4)
                            HStack {
                                Text("Spend Limit per Day").font(.system(size: 14, weight: .medium))
                                Spacer()
                                Text("\(limitPerDay)").font(.system(size: 16, weight: .bold))
                            }.padding(.horizontal, 10).padding(.bottom, 4)
                        }.padding(.bottom, 20)
                        GeometryReader { geometry in
                            ScrollView(showsIndicators: false) {
                                VStack {
                                    ForEach(0..<8){index in
                                        OverallBudgetCategoryCardView()
                                    }
                                }
                                
                            }.frame(width: geometry.size.width, height: 240)
                        }
                    }
                }
            }
    }
}

struct OverallBudgetCategoryCardView: View {
    var remainingAmount: Int = 1000
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("ColorGoldenrod"))
            .frame(width: 400, height: 191)
            .overlay {
                VStack {
                    HStack(alignment: .center) {
                        HStack{
                            Circle()
                                .fill(Color("ColorGoldenrod"))
                                .frame(width: 14, height: 14)
                            Text("Shopping")
                        }.padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("ColorSnowWhite"))
                                
                            )
                        Spacer()
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(Color("ColorCrimsonRed"))
                            .font(.system(size: 24))
                        
                    }
                    VStack {
                        Text("Remaining LKR \(remainingAmount)")
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                        VStack {
                            GeometryReader { geometry in
                                ProgressView(value: 90, total: 100)
                                    .progressViewStyle(RoundedRectProgressViewStyle(color: "ColorFreshMintGreen", width: geometry.size.width))
                                    .accentColor(Color("ColorFreshMintGreen"))
                            }.padding(.bottom, 5)
                            HStack {
                                Text("$1200 of $1200")
                                Spacer()
                                Text("140 daily")
                            }
                        }
                        .padding(.bottom, 5)
                        Text("You’ve exceed the limit!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("ColorCrimsonRed"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }.padding()
            }
    }
}

struct BudgetProgressView: View {
    @State var progressValue:Float
    @State var date: String
    @State var usedAmount: Double
    
    var body: some View {
        VStack {
            ProgressBarViewTwo(progress: self.$progressValue, date: self.$date, usedAmount: self.$usedAmount)
        }
    }
}

struct ProgressBarViewTwo: View {
    @Binding var progress: Float
    @Binding var date: String
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

struct BudgetOverView: View {
    @Binding var totalBudgetAmount: Double
    @Binding var progressValue: Float
    @Binding var date: String
    @Binding var usedAmount: Double
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 60) {
                Image(systemName: "chevron.left.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color("ColorVividBlue"))
                BudgetProgressView(progressValue: progressValue, date: date, usedAmount: usedAmount)
                    .frame(width: 175, height: 175)
                Image(systemName: "chevron.right.circle")
                    .font(.system(size: 35))
                    .foregroundColor(Color("ColorVividBlue"))
            }
            .padding(.bottom, 15)
            Text(
                """
                Monthly Budget
                LKR \(formatCurrency(value: totalBudgetAmount))
                """
            )
            .font(.system(size: 18, weight: .bold))
            .multilineTextAlignment(.center)
        }
        .padding(.bottom, 10)
        .padding(.top, 20)
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

