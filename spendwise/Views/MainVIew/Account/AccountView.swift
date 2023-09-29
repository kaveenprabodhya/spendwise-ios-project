//
//  AccountView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        VStack {
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorDeepTeal"), Color("ColorRoyalBlue")], headerContent: {})
            {
                VStack {
                    Button(action: {
                        isOnboardingViewActive = true
                    }, label: {
                       RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 2)
                            .frame(width: 376, height: 75)
                            .overlay {
                                HStack {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color("ColorGoldenrod"))
                                            .frame(width: 52, height: 52)
                                            .overlay {
                                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                                    .font(.system(size: 28))
                                                    .foregroundStyle(.white)
                                            }
                                        Text("Logout")
                                            .font(.system(size: 20))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 28))
                                        .foregroundStyle(.black)
                                }
                                .padding(.horizontal, 10)
                            }
                    })
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


