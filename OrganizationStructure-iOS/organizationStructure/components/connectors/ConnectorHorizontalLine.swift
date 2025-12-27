//
//  ConnectorHorizontalLine.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct ConnectorHorizontalLine: View {
    var color: Color = .init(hex: 0xFFCCCCCC)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let centerY = geometry.size.height / 2
                let halfWidth = geometry.size.width / 2

                if isRTL() {
                    // RTL: Draw from right (child side) to center
                    let startX = geometry.size.width
                    let endX = halfWidth
                    path.move(to: CGPoint(x: startX, y: centerY))
                    path.addLine(to: CGPoint(x: endX, y: centerY))
                } else {
                    // LTR: Draw from center to right (child side)
                    let startX = halfWidth
                    let endX = geometry.size.width
                    path.move(to: CGPoint(x: startX, y: centerY))
                    path.addLine(to: CGPoint(x: endX, y: centerY))
                }
            }
            .stroke(
                color,
                style: StrokeStyle(
                    lineWidth: 1,
                    dash: [15, 10]
                )
            )
        }
    }
}

// MARK: - Preview

struct ConnectorHorizontalLine_Previews: PreviewProvider {
    static var previews: some View {
        ConnectorHorizontalLine()
            .frame(width: 80, height: 40)
            .background(Color.gray.opacity(0.1))

        // Custom RTL
        ConnectorHorizontalLine()
            .environment(\.layoutDirection, .rightToLeft)
            .frame(width: 80, height: 40)
            .background(Color.gray.opacity(0.1))
    }
}
