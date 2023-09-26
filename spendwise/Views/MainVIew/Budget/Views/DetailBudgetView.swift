//
//  DetailBudgetView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct DetailBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State var isOnRemove: Bool = false
    var body: some View {
        VStack{
            CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [Color("ColorLavenderPurple"), Color("ColorTealGreenBlue")]){
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
                    Text("Detail Budget")
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
                    self.isOnRemove = true
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
            }
        }
        .sheet(isPresented: $isOnRemove) {
            VStack {
                Text("Remove")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical, 10)
                Text("Are you sure do you wanna remove this budget?")
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 250)
                    .padding(.bottom, 10)
                HStack {
                    Button {
                        
                    } label: {
                    }
                    .buttonStyle(CustomButtonStyle(fillColor: "ColorVividBlue", width: 164, height: 56, label: "Yes", cornerRadius: 16))
                    
                    Button {
                        dismiss()
                    } label: {
                    }
                    .buttonStyle(CustomButtonStyle(fillColor: "ColorSilverGray", width: 164, height: 56, label: "No", cornerRadius: 16))

                }
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(261)])
        }
        .background(Color.blue)
    }
}

struct DetailBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBudgetView()
    }
}
