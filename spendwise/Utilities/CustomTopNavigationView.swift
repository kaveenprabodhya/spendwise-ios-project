//
//  CustomTopNavigation.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct CustomTopNavigationView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hello, Kaveen")
                        .font(.system(size: 20, weight: .semibold))
                    Text("Welcome back.")
                        .font(.system(size: 16, weight: .regular))
                }
                Spacer()
                NavigationLink {
                    NotificationView()
                } label: {
                    Image(systemName: "bell")
                        .font(.title)
                        .foregroundColor(.white)
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
        CustomTopNavigationView()
            .previewLayout(.sizeThatFits)
            .background(.blue)
    }
}
