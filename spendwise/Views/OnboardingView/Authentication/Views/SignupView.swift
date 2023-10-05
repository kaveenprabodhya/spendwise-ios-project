//
//  SignupView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct SignupView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State var isSigninSuccess: Bool = false
    @State var isSignupClick: Bool = false
    @State private var isSecure: Bool = true
    @State private var isConfirmSecure: Bool = true
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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
                .padding(.bottom, 18)
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                TextField(text: $viewModel.name) {
                                    Text("Name")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.bottom, viewModel.errorName == nil ? 18 : 8)
                    if let error = viewModel.errorName {
                        Text("\(error)")
                            .foregroundStyle(Color("ColorCherryRed"))
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                TextField(text: $viewModel.email) {
                                    Text("Email")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.bottom, viewModel.errorEmail == nil ? 18 : 8)
                    if let error = viewModel.errorEmail {
                        Text("\(error)")
                            .foregroundStyle(Color("ColorCherryRed"))
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                if isSecure {
                                    SecureField(text: $viewModel.password) {
                                        Text("Password")
                                            .foregroundStyle(Color("ColorSteelGray"))
                                            .font(.system(size: 20, weight: .medium))
                                    }
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                                } else {
                                    TextField(text: $viewModel.password) {
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
                        .padding(.bottom, viewModel.errorPassword == nil ? 18 : 8)
                    if let error = viewModel.errorPassword {
                        Text("\(error)")
                            .foregroundStyle(Color("ColorCherryRed"))
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                    }
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .frame(width: 391, height: 62)
                        .overlay {
                            HStack {
                                if isConfirmSecure {
                                    SecureField(text: $viewModel.confirmPassword) {
                                        Text("Confirm Password")
                                            .foregroundStyle(Color("ColorSteelGray"))
                                            .font(.system(size: 20, weight: .medium))
                                    }
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                                } else {
                                    TextField(text: $viewModel.confirmPassword) {
                                        Text("Confirm Password")
                                            .foregroundStyle(Color("ColorSteelGray"))
                                            .font(.system(size: 20, weight: .medium))
                                    }
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                                }
                                Image(systemName: isConfirmSecure ? "eye.slash" : "eye")
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                                    .onTapGesture {
                                        isConfirmSecure.toggle()
                                    }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.bottom, viewModel.errorConfirmPassword == nil ? 18 : 8)
                    if let error = viewModel.errorConfirmPassword {
                        Text("\(error)")
                            .foregroundStyle(Color("ColorCherryRed"))
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                    }
                }
                Spacer()
                VStack {
                    Text("By signing up, you agree to the ")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                    + Text("Terms of Service and Privacy Policy")
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .medium))
                        .underline()
                }
                .frame(width: 380)
                .fixedSize(horizontal: true, vertical: false)
                HStack {
                    Button {
                        isSignupClick = true
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("ColorGoldenrod"))
                            .frame(width: 113, height: 48)
                            .overlay {
                                Text("Sign in")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(GrowButton())
                    .navigationDestination(isPresented: $isSignupClick) {
                        SigninView()
                    }
                    Spacer()
                    Button {
                        viewModel.register()
                        
                        if viewModel.isAuthenticated {
                            isOnboardingViewActive = false
                            isSigninSuccess = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("ColorElectricIndigo"))
                            .frame(width: 186, height: 67)
                            .overlay {
                                Text("Signup")
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
