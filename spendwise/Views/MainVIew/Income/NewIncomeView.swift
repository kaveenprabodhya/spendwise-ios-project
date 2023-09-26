//
//  NewIncomeView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewIncomeView: View {
    @Environment(\.dismiss) private var dismiss
    @State var inputAmount: String = ""
    
    var body: some View {
        VStack{
            CustomContainerBodyView(
                gradientHeight: 240,
                sheetHeight: 667,
                gradientColors: [Color("ColorForestGreen"), Color("ColorTeal")],
                headerContent: {
                    VStack {
                        Text("How Much?")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Text("LKR")
                                .foregroundColor(.white)
                                .font(.system(size: 64, weight: .semibold))
                            BottomLineTextFieldView(label: "", placeholder: "0.00", bottomLineColor: .white, textInputVal: $inputAmount)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }){
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
                    Text("Income")
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
        }
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewIncomeView()
    }
}
