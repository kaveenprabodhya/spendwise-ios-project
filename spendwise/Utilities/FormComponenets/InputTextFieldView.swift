//
//  InputTextFieldView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-24.
//

import SwiftUI

struct BottomLineTextFieldView: View {
    var label: String
    @Binding var textInputVal: String
    
    var body: some View {
        VStack {
            Text("\(label)")
                .font(.system(size: 18, weight:  .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", text: $textInputVal)
                .textFieldStyle(BottomLineTextFieldStyle())
        }.padding()
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        VStack {
            configuration
                .padding(.vertical, 5)
                .overlay(
                    Rectangle()
                        .frame(height: 2, alignment: .bottom)
                        .foregroundColor(.black)
                        .padding(.top, 24)
                )
        }
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        BottomLineTextFieldView(label: "Name of Budget", textInputVal: .constant(""))
    }
}
