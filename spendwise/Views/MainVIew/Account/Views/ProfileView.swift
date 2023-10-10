//
//  ProfileView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var viewModel: AccountViewModel = AccountViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 60)
                .fill(Color("ColorPeachyCream"))
                .frame(width: 140, height: 130)
                .overlay {
                    if let avatarImg = viewModel.avatarImage {
                        avatarImg
                            .resizable()
                            .scaledToFill()
                            .background(.red)
                            .frame(width: 112, height: 112)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 112))
                    }
                }
                .overlay {
                    VStack {
                        PhotosPicker("", selection: $viewModel.avatarItem, matching: .images)
                                .buttonStyle(
                                    CustomProfileImageButtonStyle(
                                        iconName: "camera",
                                        color: Color("ColorVividBlue"),
                                        outerCircleWidth: 56,
                                        outerCircleHeight: 53,
                                        innerCircleWidth: 46,
                                        innerCircleHeight: 43
                                    )
                                )
                            .offset(x: 40, y: 40)
                    }
                    .onChange(of: viewModel.avatarItem) { _ in
                        Task {
                            if let data = try? await viewModel.avatarItem?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    viewModel.avatarImage = Image(uiImage: uiImage)
                                    return
                                }
                            }
                            
                            print("Failed")
                        }
                    }
                }
                .padding(.vertical, 90)
            VStack(alignment: .leading) {
                if let currentUser = UserManager.shared.getCurrentUser() {
                    VStack(alignment: .leading) {
                        Text("Name")
                        Text("\(currentUser.name)")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .padding(.bottom, 48)
                    VStack(alignment: .leading) {
                        Text("Email")
                        Text("\(currentUser.email)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 55)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My Account")
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

struct CustomProfileImageButtonStyle: ButtonStyle {
    var iconName: String
    var color: Color
    var outerCircleWidth: CGFloat
    var outerCircleHeight: CGFloat
    var innerCircleWidth: CGFloat
    var innerCircleHeight: CGFloat
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
//            .frame(width: width, height: height)
            .padding()
            .overlay(
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: outerCircleWidth, height: outerCircleHeight)
                    Circle()
                        .fill(color)
                        .frame(width: innerCircleWidth, height: innerCircleHeight)
                    Image(systemName: iconName)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .medium))
                }
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
