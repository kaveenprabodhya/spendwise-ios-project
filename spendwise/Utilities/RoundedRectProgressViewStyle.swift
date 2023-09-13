//
//  RoundedRectProgressViewStyle.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-12.
//

import SwiftUI

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    var color: String
    var width: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(width), height: 8)
                .overlay(Color.white).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 360, height: 8)
                .foregroundColor(Color(color))
        }
    }
}
