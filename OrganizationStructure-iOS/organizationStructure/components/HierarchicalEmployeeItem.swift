//
//  HierarchicalEmployeeItem.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct HierarchicalEmployeeItem: View {
    let employee: EmployeeUiModel
    let depth: Int
    let isLastInSiblingGroup: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Hierarchy lines and badge
            HierarchyConnectors(
                depth: depth,
                isLastChild: isLastInSiblingGroup,
                employee: employee
            )

            // Employee details
            EmployeeDetails(employee: employee)
        }
        .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

struct HierarchicalEmployeeItem_Previews: PreviewProvider {
    static var previews: some View {
        HierarchicalEmployeeItem(
            employee: EmployeeUiModel.complexEmployees.first!,
            depth: 0,
            isLastInSiblingGroup: true
        )

        HierarchicalEmployeeItem(
            employee: EmployeeUiModel.complexEmployees.first!,
            depth: 1,
            isLastInSiblingGroup: false
        )

        HierarchicalEmployeeItem(
            employee: EmployeeUiModel.complexEmployees.first!,
            depth: 2,
            isLastInSiblingGroup: false
        )
    }
}
