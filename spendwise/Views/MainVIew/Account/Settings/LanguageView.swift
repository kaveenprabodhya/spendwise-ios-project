//
//  LanguageView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-11.
//

import SwiftUI

struct LanguageView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Language")
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

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}
