//
//  UnevenRoundedRectangleViewShape.swift
//  spendwise
//
//  Created by kaveenprabodhya on 2023-09-10.
//

import SwiftUI

struct UnevenRoundedRectangleViewShape: Shape {
    var topLeftRadius: CGFloat
    var topRightRadius: CGFloat
    var bottomLeftRadius: CGFloat
    var bottomRightRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.width
            let height = rect.height

            let topLeftRadius = min(min(self.topLeftRadius, width / 2), height / 2)
            let topRightRadius = min(min(self.topRightRadius, width / 2), height / 2)
            let bottomLeftRadius = min(min(self.bottomLeftRadius, width / 2), height / 2)
            let bottomRightRadius = min(min(self.bottomRightRadius, width / 2), height / 2)

            path.move(to: CGPoint(x: 0, y: topLeftRadius))
            path.addArc(center: CGPoint(x: topLeftRadius, y: topLeftRadius), radius: topLeftRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

            path.addLine(to: CGPoint(x: width - topRightRadius, y: 0))
            path.addArc(center: CGPoint(x: width - topRightRadius, y: topRightRadius), radius: topRightRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

            path.addLine(to: CGPoint(x: width, y: height - bottomRightRadius))
            path.addArc(center: CGPoint(x: width - bottomRightRadius, y: height - bottomRightRadius), radius: bottomRightRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

            path.addLine(to: CGPoint(x: bottomLeftRadius, y: height))
            path.addArc(center: CGPoint(x: bottomLeftRadius, y: height - bottomLeftRadius), radius: bottomLeftRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

            return path
        }
}

struct UnevenRoundedRectangleViewShape_Previews: PreviewProvider {
    static var previews: some View {
        UnevenRoundedRectangleViewShape(topLeftRadius: 30, topRightRadius: 60, bottomLeftRadius: 60, bottomRightRadius: 0).frame(width: 200, height: 100)
            .foregroundColor(Color.blue)
    }
}
