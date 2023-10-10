//
//  ContentView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-01.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @AppStorage("started") var isAlreadyStarted: Bool = false
    @State var isVisibleAlert: Bool? = false
    var alertType: AlertTypeOption? = nil
    @State var selectedTab: Int = 1
    var index: Int?
    
    var body: some View {
        NavigationStack{
            ZStack {
                if isOnboardingViewActive {
                    if isAlreadyStarted {
                        SigninView()
                    } else {
                        OnboardingView()
                    }
                } else {
                    ZStack {
                        TabView(selection: $selectedTab){
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
                            BottomNavigationBarView(index: $selectedTab)
                                .padding(.bottom, 12)
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear{
                        if let currentIndex = index {
                            selectedTab = currentIndex
                        }
                    }
                }
                if let visible = isVisibleAlert {
                    if visible {
                        ZStack {
                            if let type = alertType {
                                if type.rawValue.localizedCaseInsensitiveContains("create") {
                                    CustomAlertView(imageName: "successful-alert", iconName: "checkmark.circle.fill", message: "Successfully added.", isVisibleAlert: $isVisibleAlert)
                                }
                                if type.rawValue.localizedCaseInsensitiveContains("update") {
                                    CustomAlertView(imageName:  "update-alert", iconName: "checkmark.circle.fill", message: "Successfully updated.", isVisibleAlert: $isVisibleAlert)
                                }
                                if type.rawValue.localizedCaseInsensitiveContains("delete") {
                                    CustomAlertView(imageName: "deleted-alert", iconName: "checkmark.circle.fill", message: "Successfully deleted.", isVisibleAlert: $isVisibleAlert)
                                }
                            }
                        }
                    }
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
