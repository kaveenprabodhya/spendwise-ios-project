//
//  CurvedSideRectangle.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-02.
//

import SwiftUI

struct CurvedSideRectangleViewShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x:0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY + 60))
        path.closeSubpath()
        return path
    }
}

struct CurvedSideRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CurvedSideRectangleViewShape()
            .frame(height: 300)
    }
}
