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

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(flattenedEmployees) { flattenedEmployee in
                        HierarchicalEmployeeItem(
                            employee: flattenedEmployee.item,
                            depth: flattenedEmployee.depth,
                            isLastInSiblingGroup: flattenedEmployee.isLastInSiblingGroup
                        )
                    }
                }
                .padding(.horizontal, 16)
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
