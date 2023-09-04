//
//  CustomTopNavigation.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct CustomTopNavigationView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hello, Kaveen")
                    .font(.system(size: 20, weight: .semibold))
                Text("Welcome back.")
                    .font(.system(size: 16, weight: .regular))
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .font(.title)
                    .foregroundColor(.white)
            }
            
        }
        .foregroundColor(.white)
        .background(Color.clear)
        .padding(15)
        .padding(.horizontal,5)
        .frame(height: 64)
    }
}

struct CustomTopNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomTopNavigationView()
            .previewLayout(.sizeThatFits)
    }
}
