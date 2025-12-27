//
//  EmployeeBadge.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct EmployeeBadge: View {
    let employee: EmployeeUiModel
    let size: CGFloat = 34

    private var initials: String {
        let components = employee.name.split(separator: " ")
        let firstTwo = components.prefix(2)
        return firstTwo.compactMap { $0.first }.map { String($0).uppercased() }.joined()
    }

    var body: some View {
        Circle()
            .fill(employee.color)
            .frame(width: size, height: size)
            .overlay(
                Text(initials)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold, design: .default))
            )
    }
}

// MARK: - Preview

struct EmployeeBadge_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeBadge(employee: EmployeeUiModel.complexEmployees.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
