//
//  ConnectorVerticalLine.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//
import SwiftUI

struct ConnectorVerticalLine: View {
    var color: Color

    init(color: Color = Color(hex: 0xFFCCCCCC)) {
        self.color = color
    }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let centerX = geometry.size.width / 2
                path.move(to: CGPoint(x: centerX, y: 0))
                path.addLine(to: CGPoint(x: centerX, y: geometry.size.height))
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

struct ConnectorVerticalLine_Previews: PreviewProvider {
    static var previews: some View {
        ConnectorVerticalLine()
            .frame(width: 40, height: 80)
            .background(Color.gray.opacity(0.1))
    }
}
