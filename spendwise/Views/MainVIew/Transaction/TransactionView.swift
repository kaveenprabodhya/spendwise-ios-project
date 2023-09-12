//
//  TransactionView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
            .background(LinearGradient(gradient: Gradient(colors: [Color("ColorElectricIndigo"), Color("ColorCerulean")]), startPoint: .topTrailing, endPoint: .bottomLeading))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
