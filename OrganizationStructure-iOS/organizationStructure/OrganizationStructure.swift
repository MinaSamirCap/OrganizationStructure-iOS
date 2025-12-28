//
//  OrganizationStructure.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct OrganizationStructure: View {
    @State private var flattenedEmployees: [FlattenedEmployee] = []
    @State private var scrollViewProxy: ScrollViewProxy?

    private var maxDepth: Int {
        flattenedEmployees.map { $0.depth }.max() ?? 0
    }

    private func calculateContentWidth(screenWidth: CGFloat) -> CGFloat {
        // Each depth level adds 34 points for connectors
        // Add base width for badge (34) + spacing (12) + content (~300) + padding (32)
        let connectorWidth = CGFloat(maxDepth) * 34.0
        let baseWidth: CGFloat = 34 + 12 + 300 + 32
        return max(screenWidth, connectorWidth + baseWidth)
    }

    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { geometry in
                let contentWidth = calculateContentWidth(screenWidth: geometry.size.width)
                let actualWidth = max(geometry.size.width, contentWidth)

                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(flattenedEmployees) { flattenedEmployee in
                                HierarchicalEmployeeItem(
                                    employee: flattenedEmployee.item,
                                    depth: flattenedEmployee.depth,
                                    isLastInSiblingGroup: flattenedEmployee.isLastInSiblingGroup
                                )
                                .id(flattenedEmployee.id)
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(width: actualWidth, alignment: .leading)
                    }
                    .frame(width: actualWidth)
                }
            }
            .onAppear {
                scrollViewProxy = proxy
                flattenedEmployees = flattenHierarchy(EmployeeUiModel.complexEmployees)
            }
        }
    }
}

// MARK: - FlattenedEmployee model

struct FlattenedEmployee: Identifiable {
    let id = UUID()
    let item: EmployeeUiModel
    let depth: Int
    let isLastInSiblingGroup: Bool
}

// MARK: - Function to flatten hierarchy with depth information

private func flattenHierarchy(
    _ employees: [EmployeeUiModel],
    depth: Int = 0
) -> [FlattenedEmployee] {
    var result: [FlattenedEmployee] = []

    for (index, employee) in employees.enumerated() {
        let isLast = index == employees.count - 1
        result.append(FlattenedEmployee(
            item: employee,
            depth: depth,
            isLastInSiblingGroup: isLast
        ))

        // Recursively add children
        if !employee.children.isEmpty {
            result.append(contentsOf: flattenHierarchy(employee.children, depth: depth + 1))
        }
    }

    return result
}

// MARK: - Preview

struct OrganizationStructure_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationStructure()
            .padding()
            .frame(width: .infinity, height: .infinity)

        OrganizationStructure()
            .environment(\.layoutDirection, .rightToLeft)
            .padding()
            .frame(width: .infinity, height: .infinity)
    }
}
