//
//  AccountView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorDeepTeal"), Color("ColorRoyalBlue")], headerContent: {})
            {
                VStack {
                    Text("Hellooooo")
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


