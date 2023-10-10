//
//  AlertDeleteSuccessfullView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-10-10.
//

import SwiftUI

struct CustomAlertView: View {
    var imageName: String
    var iconName: String
    var message: String
    @Binding var isVisibleAlert: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).onTapGesture(perform: {
                isVisibleAlert = true
            })
            VStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .frame(width: 376, height: 373)
                    .overlay {
                        VStack(spacing: 0){
                            HStack {
                                Spacer()
                                Circle()
                                    .fill(.secondary)
                                    .frame(width: 28, height: 28)
                                    .overlay {
                                        Button(action: {
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundStyle(.white)
                                        })
                                    }
                                    .onTapGesture(perform: {
                                        isVisibleAlert = true
                                    })
                                    .padding(.trailing, 12)
                                    .padding(.vertical, 8)
                            }
                            .padding(.vertical, 5)
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 321, height: 186)
                            }
                            VStack {
                                Image(systemName: iconName)
                                    .font(.system(size: 48))
                                    .foregroundStyle(Color("ColorVividBlue"))
                                    .padding(.bottom, 10)
                                Text(message)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            Spacer()
                        }
                    }
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    CustomAlertView(isVisibleAlert: .constant(true))
}
