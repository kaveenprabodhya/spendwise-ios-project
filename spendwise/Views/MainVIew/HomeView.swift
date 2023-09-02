//
//  HomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            VStack{
                CurvedSideRectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorLavenderPurple"), Color("ColorTurquoiseBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 430, height: 491)
                    .edgesIgnoringSafeArea(.top)
                    .overlay {
                        Text("Hello")
                            .foregroundColor(.white)
                    }
                Spacer()
            }
            VStack{
                Text("Something")
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
