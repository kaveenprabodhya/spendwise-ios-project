//
//  FinancialReportView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct FinancialReportView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Financial Report")
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
        }
    }
}

struct FinancialReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialReportView()
    }
}
