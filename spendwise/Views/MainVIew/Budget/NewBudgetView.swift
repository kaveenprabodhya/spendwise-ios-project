//
//  NewBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct NewBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Budget")
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

struct NewBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NewBudgetView()
    }
}
