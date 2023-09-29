//
//  SignupView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct SignupView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State var nameInputVal: String = ""
    @State var emailInputVal: String = ""
    @State var passwordInputVal: String = ""
    @State var confirmPasswordInputVal: String = ""
    @State var isSigninSuccess: Bool = false
    @State var isSignupClick: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 390, height: 178)
                    .overlay {
                        Image("signup-screen")
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(.bottom, 18)
                VStack(spacing: 10) {
                    Text("Welcome to SpendWise")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Complete the sign up to get started")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 8)
                VStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                TextField(text: $nameInputVal) {
                                    Text("Name")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                
                            }
                            .padding(.horizontal, 10)
                        }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                TextField(text: $emailInputVal) {
                                    Text("Email")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                
                            }
                            .padding(.horizontal, 10)
                        }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                SecureField(text: $passwordInputVal) {
                                    Text("Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                Image(systemName: "eye")
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .padding(.horizontal, 10)
                        }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                SecureField(text: $confirmPasswordInputVal) {
                                    Text("Confirm Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                Image(systemName: "eye")
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .padding(.horizontal, 10)
                        }
                }
                Spacer()
                VStack {
                    Text("By signing up, you agree to the ")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                    + Text("Terms of Service and Privacy Policy")
                        .foregroundColor(.blue)
                        .font(.system(size: 20, weight: .medium))
                        .underline()
                }
                HStack {
                    Button {
                        isSignupClick = true
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("ColorGoldenrod"))
                            .frame(width: 113, height: 48)
                            .overlay {
                                Text("Sign up")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(GrowButton())
                    .navigationDestination(isPresented: $isSignupClick) {
                        SignupView()
                    }
                    Spacer()
                    Button {
                        isOnboardingViewActive = false
                        isSigninSuccess = true
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("ColorElectricIndigo"))
                            .frame(width: 186, height: 67)
                            .overlay {
                                Text("Sign in")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(GrowButton())
                    .navigationDestination(isPresented: $isSigninSuccess) {
                        ContentView()
                    }
                }
                .padding(.horizontal, 15)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                gradient: Gradient(colors: [Color("ColorElectricIndigo"), Color("ColorCerulean")]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Signup")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
        }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
