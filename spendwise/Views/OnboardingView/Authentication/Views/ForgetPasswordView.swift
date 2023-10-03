//
//  ForgetPasswordView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct ForgetPasswordView: View {
    @State var emailInputVal: String = ""
    @State var newPasswordInputVal: String = ""
    @State var retypenewPasswordInputVal: String = ""
    @State private var isSecure: Bool = true
    @State private var isValidEmail: Bool = false
    @State private var hideEmail: Bool = false
    @State private var isChangePasswordSuccess: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            if !hideEmail {
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
                    .padding(.vertical, 10)
                Button {
                    hideEmail = true
                    isValidEmail = true
                } label: {
                    
                }
                .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Continue", cornerRadius: 35))
            }
            if isValidEmail {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 391, height: 62)
                    .overlay {
                        HStack {
                            if isSecure {
                                SecureField(text: $newPasswordInputVal) {
                                    Text("New Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            } else {
                                TextField(text: $newPasswordInputVal) {
                                    Text("New Password")
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
                    .padding(.top, 10)
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 391, height: 62)
                    .overlay {
                        HStack {
                            if isSecure {
                                SecureField(text: $retypenewPasswordInputVal) {
                                    Text("Retype new password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            } else {
                                TextField(text: $retypenewPasswordInputVal) {
                                    Text("Retype new password")
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
                    .padding(.bottom, 10)
                Button {
                    isChangePasswordSuccess = true
                } label: {
                    
                }
                .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Continue", cornerRadius: 35))
                .navigationDestination(isPresented: $isChangePasswordSuccess) {
                    SigninView()
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("ColorCerulean"), Color("ColorElectricIndigo")]),
                startPoint: .top,
                endPoint: .bottom)
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Forget Password")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
