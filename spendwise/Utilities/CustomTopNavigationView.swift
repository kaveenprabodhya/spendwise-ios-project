//
//  CustomTopNavigation.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct CustomTopNavigationView: View {
    var userName: String
    var userRegistered: Bool = false
    @State var newCount: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hello, \(userName)")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.bottom, 6)
                    if userRegistered {
                        Text("Welcome to SpendWise")
                            .font(.system(size: 18, weight: .regular))
                    } else {
                        Text("Welcome back.")
                            .font(.system(size: 18, weight: .regular))
                    }
                }
                Spacer()
                NavigationLink {
                    NotificationView(newCount: $newCount)
                } label: {
                    Image(systemName: "bell")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
                .overlay {
                    Circle()
                        .fill(.black)
                        .frame(width: 20, height: 20)
                        .offset(x: 10, y: -12)
                        .overlay {
                            Text("\(newCount)")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .offset(x: 10, y: -12)
                        }
                }
                
            }
            .foregroundColor(.white)
            .background(Color.clear)
            .padding(20)
            .frame(height: 64)
        }.padding(.vertical, 8)
    }
}

struct CustomTopNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomTopNavigationView(userName: "Kaveen", userRegistered: true)
            .previewLayout(.sizeThatFits)
            .background(.blue)
    }
}
