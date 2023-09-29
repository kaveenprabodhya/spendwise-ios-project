//
//  SecurityView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-11.
//

import SwiftUI

struct SecurityView: View {
    @Environment(\.dismiss) private var dismiss
    @State var passwordInputVal: String = ""
    @State var confirmPasswordInputVal: String = ""
    @State private var isOldPasswordInputVal: String = ""
    @State private var isSecure: Bool = true
    @State private var isConfirmSecure: Bool = true
    @State private var isOldSecure: Bool = true
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(.clear)
                .frame(height: 73)
                .overlay {
                    HStack(alignment: .center) {
                        Text("Password")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(Color("ColorVividBlue"))
                    }
                    .padding(.horizontal, 18)
                }
            Text("Reset your Password")
                .font(.system(size: 20, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 18)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("ColorEtherealMist"))
                .frame(width: 391, height: 88)
                .overlay {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Old Password")
                            .foregroundStyle(Color("ColorSteelGray"))
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                        HStack {
                            if isOldSecure {
                                SecureField(text: $isOldPasswordInputVal) {
                                    Text("Old Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            } else {
                                TextField(text: $isOldPasswordInputVal) {
                                    Text("Old Password")
                                        .foregroundStyle(Color("ColorSteelGray"))
                                        .font(.system(size: 20, weight: .medium))
                                }
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                            }
                            Image(systemName: isOldSecure ? "eye.slash" : "eye")
                                .foregroundStyle(Color("ColorSteelGray"))
                                .font(.system(size: 20, weight: .medium))
                                .onTapGesture {
                                    isOldSecure.toggle()
                                }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.bottom, 10)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("ColorEtherealMist"))
                .frame(width: 391, height: 88)
                .overlay {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("New Password")
                            .foregroundStyle(Color("ColorSteelGray"))
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                    HStack {
                        if isSecure {
                            SecureField(text: $passwordInputVal) {
                                Text("New Password")
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .foregroundStyle(Color("ColorSteelGray"))
                            .font(.system(size: 20, weight: .medium))
                        } else {
                            TextField(text: $passwordInputVal) {
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
                }
                .padding(.bottom, 10)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("ColorEtherealMist"))
                .frame(width: 391, height: 88)
                .overlay {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("New Confirm Password")
                            .foregroundStyle(Color("ColorSteelGray"))
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                    HStack {
                        if isConfirmSecure {
                            SecureField(text: $confirmPasswordInputVal) {
                                Text("New Confirm Password")
                                    .foregroundStyle(Color("ColorSteelGray"))
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .foregroundStyle(Color("ColorSteelGray"))
                            .font(.system(size: 20, weight: .medium))
                        } else {
                            TextField(text: $confirmPasswordInputVal) {
                                Text("New Confirm Password")
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
                }
                .padding(.bottom, 10)
            Spacer()
            Button {
                
            } label: {}
            .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 403, height: 68, label: "Save", cornerRadius: 35))
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Security")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color.black)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
