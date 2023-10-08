//
//  HomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State var index = 0
    @State var expand = false
    @ObservedObject var viewModel: BudgetViewModel = BudgetViewModel()
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack{
            VStack(spacing: 0) {
                VStack{
                    CurvedSideRectangleViewShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorDarkLavenderPurple"), Color("ColorDarkTurquoiseBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 430, height: 480)
                        .edgesIgnoringSafeArea(.top)
                        .overlay {
                            VStack{
                                VStack{
                                    if let currentUser = UserManager.shared.getCurrentUser() {
                                        CustomTopNavigationView(userName: currentUser.name)
                                    }
                                }
                                .padding(.top, 26)
                                VStack {
                                    VStack {
                                        Text(Date.now, format: .dateTime.day().month().year())
                                            .font(.system(size: 22))
                                            .foregroundColor(.white)
                                            .fontWeight(.medium)
                                    }
                                    .background(Color.clear)
                                    .offset(y: -6)
                                }
                                VStack {
                                    Ellipse()
                                        .fill(Color("ColorSnowWhite"))
                                        .frame(width: 72, height: 72)
                                        .overlay{
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 45, height: 45, alignment: .center)
                                                .foregroundColor(Color("ColorSilverGray"))
                                        }
                                    VStack(spacing: 8) {
                                        Text("Your available balance is")
                                            .foregroundColor(.white)
                                        Text("LKR \(formatCurrency(value: (viewModel.overview.overallAmount)))")
                                            .font(.system(size: 28))
                                            .foregroundColor(.white)
                                        if homeViewModel.prevoiusMonthlyAverage.amount > 0 {
                                            Text("By this time last month, you spent slightly higher (\(formatCurrency(value: homeViewModel.prevoiusMonthlyAverage.amount)))")
                                            .frame(width: 250)
                                            .lineLimit(nil)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                }
                                VStack {
                                    Spacer()
                                    Spacer()
                                    HStack(spacing: 20) {
                                        RoundedRectangle(cornerRadius: 20.0)
                                            .fill(Color("ColorEmeraldGreen"))
                                            .frame(width: 164, height: 82, alignment: .bottomLeading)
                                            .overlay {
                                                HStack {
                                                    RoundedRectangle(cornerRadius: 20.0)
                                                        .fill(Color("ColorSnowWhite"))
                                                        .frame(width: 48, height: 49, alignment: .leading)
                                                        .overlay{
                                                            Image(systemName: "square.and.arrow.down.fill")
                                                                .font(.system(size: 26))
                                                                .foregroundColor(Color("ColorEmeraldGreen"))
                                                        }
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Text("Income")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 14))
                                                        Text("LKR \(formatCurrency(value: viewModel.overview.overallIncomeAmount))")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                    }
                                                }
                                                .padding(5)
                                            }
                                        RoundedRectangle(cornerRadius: 20.0)
                                            .fill(Color("ColorRustyRed"))
                                            .frame(width: 164, height: 82, alignment: .bottomLeading)
                                            .overlay {
                                                HStack {
                                                    RoundedRectangle(cornerRadius: 20.0)
                                                        .fill(Color("ColorSnowWhite"))
                                                        .frame(width: 48, height: 49, alignment: .leading)
                                                        .overlay{
                                                            Image(systemName: "square.and.arrow.up.fill")
                                                                .font(.system(size: 26))
                                                                .foregroundColor(Color("ColorRustyRed"))
                                                        }
                                                    VStack(alignment: .leading, spacing: 10) {
                                                        Text("Expense")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 14))
                                                        Text("LKR \(formatCurrency(value: viewModel.overview.overallExpenseAmount))")
                                                            .foregroundColor(Color("ColorSnowWhite"))
                                                            .font(.system(size: 16))
                                                            .fontWeight(.semibold)
                                                    }
                                                }
                                                .padding(5)
                                            }
                                    }
                                    Spacer()
                                }
                            }
                        }
                }
                .padding(.bottom, 16)
                VStack {
                    Spacer()
                    ScrollView(showsIndicators: false) {
                            VStack {
                                WeeklyBarChartView()
                                Spacer()
                            }
                            VStack {
                                TabView {
                                    BudgetChartView(filterBudgetArray: viewModel.budgetArray, type: .weekly)
                                        .tag(0)
                                    BudgetChartView(filterBudgetArray: viewModel.budgetArray, type: .monthly)
                                        .tag(1)
                                    BudgetChartView(filterBudgetArray: viewModel.budgetArray, type: .yearly)
                                        .tag(2)
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                                .frame(width: 400 , height: 350)
                                Spacer()
                            }
                    }
                    Spacer()
                }.padding(.top, 15)
            }
        }
        .onAppear{
            if let currentUser = UserManager.shared.getCurrentUser() {
                viewModel.fetchBudgetData(currentUser: currentUser)
                viewModel.fetchAmountSpentForLast7Days(currentUser: currentUser)
                viewModel.fetchOverallBudgetForUser(currentUser: currentUser)
                homeViewModel.fetchPrevoiusMonthlyAverage(currentUser: currentUser)
                homeViewModel.fetchOngoingWeekExpenseAndIncomeByDay(currentUser: currentUser)
            }
            setupAppearance()
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
