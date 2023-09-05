//
//  BottomNavigationBarView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-03.
//

import SwiftUI

struct BottomNavigationBarView: View {
    var body: some View {
        ZStack {
            Color.blue.background(.ultraThinMaterial)
            Text("Overlay at the Bottom")
                .foregroundColor(.white)
        }
        .frame(height: 81)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct BottomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBarView()
    }
}
