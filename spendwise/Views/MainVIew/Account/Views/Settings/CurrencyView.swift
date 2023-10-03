//
//  CurrencyView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-11.
//

import SwiftUI

struct CurrencyView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            Rectangle()
                .fill(.clear)
                .frame(height: 73)
                .overlay {
                    HStack(alignment: .center) {
                        Text("Rupees (LKR)")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(Color("ColorVividBlue"))
                    }
                    .padding(.horizontal, 18)
                }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Currency")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color.black)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
