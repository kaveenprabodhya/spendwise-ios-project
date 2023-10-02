//
//  LoginView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct SigninView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State var emailInputVal: String = ""
    @State var passwordInputVal: String = ""
    @State var isSigninSuccess: Bool = false
    @State var isForetPasswordSuccess: Bool = false
    @State var isSignupClick: Bool = false
    @State private var isSecure: Bool = true
    @State private var isForgetPasswordOn: Bool = false
    
    var body: some View {
        VStack {
            Circle()
                .fill(.clear)
                .frame(width: 320, height: 280)
                .overlay {
                    Image("login-screen")
                        .resizable()
                        .scaledToFill()
                }
                .padding(.vertical, 8)
            VStack(alignment: .leading, spacing: 10) {
                Text("Welcome Back")
                    .foregroundStyle(.white)
                    .font(.system(size: 24, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Hey you’re back, fill in your details to log in")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .medium))
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 18)
            VStack(spacing: 0) {
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
                    .padding(.bottom, 18)
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 391, height: 62)
                    .overlay {
                        HStack {
                            if isSecure {
                                SecureField(text: $passwordInputVal) {
                                    Text("Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            } else {
                                TextField(text: $passwordInputVal) {
                                    Text("Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            }
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                                .onTapGesture {
                                    isSecure.toggle()
                                }
                        }
                        .padding(.horizontal, 10)
                    }
                VStack {
                    Text("Forget password?")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .onTapGesture {
                            isForgetPasswordOn = true
                        }
                        .navigationDestination(isPresented: $isForgetPasswordOn) {
                            ForgetPasswordView()
                        }
                }
                .padding(.top, 25)
                .padding(.trailing, 20)
                .padding(.bottom, 18)
                Spacer()
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
            }
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
                    Text("Sign in")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct GrowButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
