//
//  EmployeeDetails.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct EmployeeDetails: View {
    let employee: EmployeeUiModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(employee.name)
                .font(.headline)

            EmployeeDescriptionItem(
                description: employee.position,
                icon: "person.fill"
            )

            EmployeeDescriptionItem(
                description: employee.location,
                icon: "location.fill"
            )
        }
        .frame(minWidth: 0, alignment: .leading)
    }
}

// MARK: - Preview

struct EmployeeDetails_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetails(employee: EmployeeUiModel.complexEmployees.first!)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
