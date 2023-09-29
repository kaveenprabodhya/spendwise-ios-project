//
//  ProfileView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 60)
                .fill(Color("ColorPeachyCream"))
                .frame(width: 140, height: 130)
                .overlay {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 112))
                }
                .overlay {
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 56, height: 53)
                            Circle()
                                .fill(Color("ColorVividBlue"))
                                .frame(width: 46, height: 43)
                            Image(systemName: "camera")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .medium))
                        }
                    })
                    
                    .offset(x: 40, y: 40)
                }
                .padding(.vertical, 90)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Name")
                    Text("Kaveen Prabodhya")
                }
                .padding(.bottom, 48)
                VStack(alignment: .leading) {
                    Text("Email")
                    Text("kaveen@gmail.com")
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
