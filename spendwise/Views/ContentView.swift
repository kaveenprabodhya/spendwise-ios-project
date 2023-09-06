//
//  ContentView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-01.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                ZStack {
//                    TabView{
//                        Group {
//                            HomeView()
//                                .tabItem {
//                                    Label("Home", systemImage: "house.fill")
//                                }
//                            TransactionView()
//                                .tabItem {
//                                    Label("Transactions", systemImage: "arrow.left.arrow.right.square")
//                                }
//                            BudgetView()
//                                .tabItem {
//                                    Label("Budget", systemImage: "chart.pie.fill")
//                                }
//                            AccountView()
//                                .tabItem {
//                                    Label("Budget", systemImage: "person.crop.circle")
//                                }
//                        }
//                        .toolbarBackground(Color("ColorElectricIndigo"), for: .tabBar)
//                        .toolbarBackground(.visible, for: .tabBar)
//                    }
                    HomeView()
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
