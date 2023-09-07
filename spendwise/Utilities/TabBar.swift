//
//  TabBar.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-06.
//

import SwiftUI

struct TabBar: View {
    @Binding var index: Int
    @Binding var expand: Bool
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                self.index = 1
            } label: {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(self.index == 1 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 2
            } label: {
                Image(systemName: "arrow.left.arrow.right.square")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(self.index == 2 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                withAnimation(Animation.linear(duration: 0.3)) {
                    self.expand.toggle()
                }
            } label: {
                Image(systemName: self.expand ? "xmark" : "plus")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundColor(Color("ColorWhite"))
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .offset(y: -18)
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 3
            } label: {
                Image(systemName: "chart.pie.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(self.index == 3 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
            
            Spacer(minLength: 0)
            
            Button {
                self.index = 4
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(self.index == 4 ? Color("ColorWhite") : Color("ColorPaleGray"))
                    .scaledToFit()
            }
        }
        .padding(.horizontal, 30)
    }
}
