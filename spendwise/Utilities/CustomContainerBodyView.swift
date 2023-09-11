//
//  CustomContainerBodyView.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-11.
//

import SwiftUI

struct CustomContainerBodyView<Content: View>: View {
    var gradientHeight: CGFloat
    var sheetHeight: CGFloat
    var gradientColors: [Color]
    let content: Content
    
    init(gradientHeight: CGFloat, sheetHeight: CGFloat, gradientColors: [Color], @ViewBuilder content: () -> Content) {
            self.gradientHeight = gradientHeight
            self.sheetHeight = sheetHeight
            self.gradientColors = gradientColors
            self.content = content()
        }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .background(LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ))
                    .frame(width: geometry.size.width, height: gradientHeight)
                
            }
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear.frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    
                }
                .overlay(content: {
                    GeometryReader { geometry in
                        VStack {
                            UnevenRoundedRectangleViewShape(topLeftRadius: 30,topRightRadius: 30, bottomLeftRadius: 0, bottomRightRadius: 0)
                                .fill(.white)
                                .frame(height: sheetHeight)
                                .overlay {
                                    content
                                }
                        }
                        .frame(width: geometry.size.width, height: sheetHeight)
                        .frame(maxHeight: .infinity, alignment: .bottom )
                    }
                })
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct CustomContainerBodyView_Previews: PreviewProvider {
    static var previews: some View {
        CustomContainerBodyView(gradientHeight: 240, sheetHeight: 667, gradientColors: [.blue, .green], content: {Text("Hello")})
    }
}
