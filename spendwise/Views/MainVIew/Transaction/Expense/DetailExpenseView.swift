//
//  DetailsExpenseView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct DetailExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorBrickRed"), Color("ColorDeepEspressoBrown")], headerContent: {}){
                VStack {
                    Text("Hellooooo")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Detail Transaction")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
            }
        }
    }
}

struct DetailExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        DetailExpenseView()
    }
}
