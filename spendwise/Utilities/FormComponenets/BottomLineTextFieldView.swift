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
    var bottomLinePadding: CGFloat?
    var placeholderColor: Color?
    var labelSize: CGFloat?
    var textFieldFontSize: CGFloat?
    var placeholderFontSize: CGFloat?
    var textFieldHeight: CGFloat?
    var textFieldWidth: CGFloat?
    var textFieldWeight: Font.Weight?
    var alignCetner: Bool
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
            GeometryReader(content: { geometry in
                TextField(
                    "",
                    text: $textInputVal,
                    prompt: Text("\(placeholder)")
                        .font(.system(size: placeholderFontSize != nil ? placeholderFontSize! : 24, weight: .medium))
                        .foregroundColor(placeholderColor != nil ? placeholderColor! : .black)
                )
                .multilineTextAlignment(alignCetner ? .center : .leading)
                .frame(width: textFieldWidth != nil ? textFieldWidth! : geometry.size.width, height: textFieldHeight != nil ? textFieldHeight! : geometry.size.height)
                .foregroundColor(fontColor != nil ? fontColor! : .black)
                .textFieldStyle(BottomLineTextFieldStyle(bottomLineColor: bottomLineColor, bottomLinePadding: bottomLinePadding))
                .font(.system(size: textFieldFontSize != nil ? textFieldFontSize! : 24, weight: textFieldWeight != nil ? textFieldWeight! : .medium))
            })
        }
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    var bottomLineColor: Color?
    var bottomLinePadding: CGFloat?
    
    func _body(configuration: TextField<_Label>) -> some View {
        VStack {
            configuration
                .overlay(
                    Rectangle()
                        .frame(height: 2, alignment: .bottom)
                        .foregroundColor(bottomLineColor != nil ? bottomLineColor! : .black)
                        .padding(.top, bottomLinePadding != nil ? bottomLinePadding! : 34)
                )
        }
    }
}

struct BottomLineTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        BottomLineTextFieldView(label: "", placeholder: "Type....", fontColor: .blue, bottomLineColor: .blue, bottomLinePadding: 64, placeholderColor: .green, labelSize: 20, textFieldFontSize: 32, alignCetner: false, textInputVal: .constant(""))
            .padding()
    }
}
