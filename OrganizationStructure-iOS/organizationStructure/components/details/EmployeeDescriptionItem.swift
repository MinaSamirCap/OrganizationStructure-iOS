//
//  EmployeeDescriptionItem.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import SwiftUI

struct EmployeeDescriptionItem: View {
    let description: String
    let icon: String // SF Symbols system name

    init(description: String, icon: String) {
        self.description = description
        self.icon = icon
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(Color(hex: 0xFF666666))

            Text(description)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: 0xFF666666))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

struct EmployeeDescriptionItem_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDescriptionItem(
            description: "Sheikh Zayed St., Dubai, UAE",
            icon: "location.fill"
        )
        .padding(.horizontal)
    }
}
