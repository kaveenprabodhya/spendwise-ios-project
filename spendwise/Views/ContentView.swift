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
                                .tag(1)
                            TransactionView()
                                .tag(2)
                            BudgetView()
                                .tag(3)
                            AccountView()
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
