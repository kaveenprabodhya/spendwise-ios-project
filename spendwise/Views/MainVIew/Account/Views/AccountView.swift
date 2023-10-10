//
//  AccountView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State var isLogoutClicked: Bool = false
    @State var isAccountClicked: Bool = false
    @State var isSettingsClicked: Bool = false
    
    var body: some View {
        VStack {
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorDeepTeal"), Color("ColorRoyalBlue")], headerContent: {
                VStack {
                    HStack(alignment: .center) {
                        Circle()
                            .fill(Color("ColorPeachyCream"))
                            .frame(width: 80, height: 80)
                            .overlay {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 72))
                                    .foregroundStyle(.black)
                            }
                            .padding(.trailing, 15)
                        VStack(alignment: .trailing) {
                            if let currentUser = UserManager.shared.getCurrentUser() {
                                Text("\(currentUser.name)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.white)
                                Text("\(currentUser.email)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                                    .tint(.white)
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
            })
            {
                VStack {
                    Button(action: {
                        isAccountClicked = true
                    }, label: {
                       RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 1)
                            .frame(width: 376, height: 75)
                            .overlay {
                                HStack {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color("ColorCrimsonBlaze"))
                                            .frame(width: 52, height: 52)
                                            .overlay {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .font(.system(size: 28))
                                                    .foregroundStyle(.white)
                                            }
                                        Text("Account")
                                            .font(.system(size: 20))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundStyle(Color(.systemGray))
                                }
                                .padding(.horizontal, 10)
                            }
                    })
                    .navigationDestination(isPresented: $isAccountClicked) {
                        ProfileView()
                    }
                    Button(action: {
                       isSettingsClicked = true
                    }, label: {
                       RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 1)
                            .frame(width: 376, height: 75)
                            .overlay {
                                HStack {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color("ColorCrimsonBlaze"))
                                            .frame(width: 52, height: 52)
                                            .overlay {
                                                Image(systemName: "gearshape.fill")
                                                    .font(.system(size: 28))
                                                    .foregroundStyle(.white)
                                            }
                                        Text("Settings")
                                            .font(.system(size: 20))
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 22, weight: .regular))
                                        .foregroundStyle(Color(.systemGray))
                                }
                                .padding(.horizontal, 10)
                            }
                    })
                    .navigationDestination(isPresented: $isSettingsClicked) {
                        SettingsView()
                    }
                    Spacer()
                    Button(action: {
                        isLogoutClicked = true
                    }, label: {
                       RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 1)
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
                                    
                                }
                                .padding(.horizontal, 10)
                            }
                    })
                    .padding(.bottom, 22)
                    Text("You joined SpenWise on Jan 2023. It’s been 1 month since then and our mission is still the same, help you better manage your finance like a SpendWise.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)
                    Spacer()
                }
                .padding(.vertical, 15)
            }
        }
        .sheet(isPresented: $isLogoutClicked, content: {
            VStack {
                Spacer()
                Text("Logout?")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                Text("Are you sure do you wanna logout?")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 250)
                    .padding(.bottom, 30)
                HStack {
                    Button {
                        isOnboardingViewActive = true
                    } label: {
                    }
                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 164, height: 56, label: "Yes", cornerRadius: 16))
                    
                    Button {
                        withAnimation(.linear(duration: 0.25)) {
                            self.isLogoutClicked = false
                        }
                    } label: {
                    }
                    .buttonStyle(CustomButtonStyle(fillColor: "ColorSilverGray", width: 164, height: 56, label: "No", cornerRadius: 16))
                    
                }
                Spacer()
            }
            .presentationDetents([.height(261)])
            .presentationDragIndicator(.visible)
            .presentationBackground(.orange)
            .presentationCornerRadius(25)
        })
        .navigationBarHidden(true)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


