//
//  InputTextFieldView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-24.
//

import SwiftUI

struct BottomLineTextFieldView: View {
    var label: String
    var placeholder: String
    @Binding var textInputVal: String
    
    var body: some View {
        VStack {
            if !label.isEmpty {
                Text("\(label)")
                    .font(.system(size: 18, weight:  .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            TextField("\(placeholder)", text: $textInputVal)
                .foregroundColor(.black)
                .textFieldStyle(BottomLineTextFieldStyle())
                .font(.system(size: 24))
        }.padding()
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        VStack {
            configuration
                .overlay(
                    Rectangle()
                        .frame(height: 2, alignment: .bottom)
                        .foregroundColor(.black)
                        .padding(.top, 45)
                )
        }
    }
}

struct BottomLineTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        BottomLineTextFieldView(label: "Name of Budget", placeholder: "Type....", textInputVal: .constant(""))
    }
}
