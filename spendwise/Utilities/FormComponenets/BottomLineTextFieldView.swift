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
    var fontColor: Color?
    var bottomLineColor: Color?
    var placeholderColor: Color?
    var labelSize: CGFloat?
    var textFieldFontSize: CGFloat?
    var placeholderFontSize: CGFloat?
    @Binding var textInputVal: String
    
    var body: some View {
        VStack(spacing: 0) {
            if !label.isEmpty {
                Text("\(label)")
                    .foregroundColor(fontColor != nil ? fontColor! : .black)
                    .font(.system(size: labelSize != nil ? labelSize! : 18, weight:  .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 6)
            }
            TextField("", text: $textInputVal, prompt: Text("\(placeholder)").font(.system(size: placeholderFontSize != nil ? placeholderFontSize! : 24, weight: .medium)).foregroundColor(placeholderColor != nil ? placeholderColor! : .black))
                .foregroundColor(fontColor != nil ? fontColor! : .black)
                .textFieldStyle(BottomLineTextFieldStyle(bottomLineColor: bottomLineColor))
                .font(.system(size: textFieldFontSize != nil ? textFieldFontSize! : 24))
        }.padding()
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    var bottomLineColor: Color?
    
    func _body(configuration: TextField<_Label>) -> some View {
        VStack {
            configuration
                .overlay(
                    Rectangle()
                        .frame(height: 2, alignment: .bottom)
                        .foregroundColor(bottomLineColor != nil ? bottomLineColor! : .black)
                        .padding(.top, 45)
                )
        }
    }
}

struct BottomLineTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        BottomLineTextFieldView(label: "Name of Budget", placeholder: "Type....", fontColor: .blue, bottomLineColor: .blue, placeholderColor: .green, labelSize: 32, textFieldFontSize: 32, textInputVal: .constant(""))
    }
}
