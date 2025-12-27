//
//  HierarchyConnectors.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//
import SwiftUI

struct HierarchyConnectors: View {
    let depth: Int
    let isLastChild: Bool
    let employee: EmployeeUiModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Horizontal connectors for each depth level
            ForEach(0 ..< depth, id: \.self) { i in
                let currentDepth = i + 1
                
                ZStack {
                    // Horizontal line (drawn at specific depth)
                    if depth - currentDepth == 0 {
                        BoxView(size: 34) {
                            ConnectorHorizontalLine()
                                .frame(width: 34, height: 1)
                        }
                    }
                    
                    // Vertical line logic
                    if isLastChild && (depth - currentDepth == 0) {
                        // Draw till half of badge
                        BoxView(width: 34) {
                            ConnectorVerticalLine()
                                .frame(width: 1, height: 16) // half of badge size
                        }
                    } else {
                        // Draw full vertical line or skip
                        BoxView(width: 34) {
                            if !employee.doNotDrawDepth.contains(i) {
                                ConnectorVerticalLine()
                                    .frame(width: 1, height: 80)
                            }
                        }
                    }
                }
                .frame(width: 34)
            }
            
            // Employee badge with optional vertical connector below
            VStack(alignment: .center, spacing: 0) {
                EmployeeBadge(employee: employee)
                
                // Draw vertical line below badge if employee has children
                if !employee.children.isEmpty {
                    ConnectorVerticalLine()
                        .frame(width: 1, height: 40)
                }
            }
        }
    }
}

// Helper view for box with centered content (like Compose's Box)
struct BoxView<Content: View>: View {
    let width: CGFloat?
    let height: CGFloat?
    let content: Content
    
    init(width: CGFloat? = nil, height: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.width = width
        self.height = height
        self.content = content()
    }
    
    init(size: CGFloat, @ViewBuilder content: () -> Content) {
        self.width = size
        self.height = size
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if let width = width, let height = height {
                Color.clear
                    .frame(width: width, height: height)
                    .overlay(content, alignment: .center)
            } else if let width = width {
                Color.clear
                    .frame(width: width)
                    .overlay(content, alignment: .center)
            } else if let height = height {
                Color.clear
                    .frame(height: height)
                    .overlay(content, alignment: .center)
            } else {
                Color.clear
                    .overlay(content, alignment: .center)
            }
        }
    }
}

// MARK: - Preview

struct HierarchyConnectors_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 30) {
            HierarchyConnectors(
                depth: 0,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            HierarchyConnectors(
                depth: 1,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            HierarchyConnectors(
                depth: 2,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            // Test with isLastChild = true
            HierarchyConnectors(
                depth: 2,
                isLastChild: true,
                employee: EmployeeUiModel.complexEmployees.first!
            )
        }
        
        VStack(alignment: .leading, spacing: 30) {
            HierarchyConnectors(
                depth: 0,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            HierarchyConnectors(
                depth: 1,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            HierarchyConnectors(
                depth: 2,
                isLastChild: false,
                employee: EmployeeUiModel.complexEmployees.first!
            )
            
            // Test with isLastChild = true
            HierarchyConnectors(
                depth: 2,
                isLastChild: true,
                employee: EmployeeUiModel.complexEmployees.first!
            )
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}
