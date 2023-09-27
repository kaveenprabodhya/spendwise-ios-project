//
//  RoundedRectProgressViewStyle.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-12.
//

import SwiftUI

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    var color: Color
    var width: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        RoundedRectangle(cornerRadius: 10.0)
            .fill(Color(uiColor: .systemGray5))
            .frame(height: 8)
            .frame(width: width)
            .overlay(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(color)
                    .frame(width: width * progress)
                    .overlay {
                        if let currentValueLabel = configuration.currentValueLabel {
                            currentValueLabel
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
            }
    }
}
