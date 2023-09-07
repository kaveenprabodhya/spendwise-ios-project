//
//  ContentView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-01.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State var index = 1
    var body: some View {
        NavigationStack{
            ZStack {
                if isOnboardingViewActive {
                    OnboardingView()
                } else {
                    ZStack {
                        TabView(selection: $index){
                            HomeView()
                            //                            .tabItem {
                            //                                Label("Home", systemImage: "house.fill")
                            //                            }
                                .tag(1)
                            TransactionView()
                            //                            .tabItem {
                            //                                Label("Transactions", systemImage: "arrow.left.arrow.right.square")
                            //                            }
                                .tag(2)
                            BudgetView()
                            //                            .tabItem {
                            //                                Label("Budget", systemImage: "chart.pie.fill")
                            //                            }
                                .tag(3)
                            AccountView()
                            //                            .tabItem {
                            //                                Label("Budget", systemImage: "person.crop.circle")
                            //                            }
                                .tag(4)
                        }
                        .overlay(alignment: .bottom) {
                            BottomNavigationBarView(index: $index)
                                .padding(.bottom, 12)
                        }
                    }.edgesIgnoringSafeArea(.bottom)
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
