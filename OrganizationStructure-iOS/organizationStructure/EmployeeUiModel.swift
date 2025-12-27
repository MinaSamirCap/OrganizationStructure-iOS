//
//  EmployeeUiModel.swift
//  OrganizationStructure-iOS
//
//  Created by Mina Samir on 27/12/2025.
//

import Foundation
import SwiftUI

struct EmployeeUiModel: Identifiable, Equatable {
    let id: String
    let name: String
    let position: String
    let location: String
    let color: Color
    let children: [EmployeeUiModel]
    var doNotDrawDepth: [Int]

    // Default values in Swift - using static methods instead of default parameters for complex cases
    init(
        id: String,
        name: String,
        position: String,
        location: String,
        color: Color = Color(red: 0.129, green: 0.588, blue: 0.953), // #FF2196F3
        children: [EmployeeUiModel] = [],
        doNotDrawDepth: [Int] = []
    ) {
        self.id = id
        self.name = name
        self.color = color
        self.position = position
        self.location = location
        self.children = children
        self.doNotDrawDepth = doNotDrawDepth
    }

    // Helper to create mutable copy for doNotDrawDepth modifications
    func withDoNotDrawDepth(_ depth: [Int]) -> EmployeeUiModel {
        var copy = self
        copy.doNotDrawDepth = depth
        return copy
    }

    // Recursive function to mark depths not to be drawn
    static func markDepthToBeNotDrawn(model: EmployeeUiModel, depth: Int) -> EmployeeUiModel {
        var modifiedModel = model

        if !model.children.isEmpty {
            var modifiedChildren: [EmployeeUiModel] = []
            for child in model.children {
                var modifiedChild = child
                modifiedChild.doNotDrawDepth.append(depth)
                modifiedChild = markDepthToBeNotDrawn(model: modifiedChild, depth: depth)
                modifiedChildren.append(modifiedChild)
            }
            modifiedModel = EmployeeUiModel(
                id: model.id,
                name: model.name,
                position: model.position,
                location: model.location,
                color: model.color,
                children: modifiedChildren,
                doNotDrawDepth: model.doNotDrawDepth
            )
        }

        return modifiedModel
    }
}

// MARK: - Sample Data

extension EmployeeUiModel {
    static let simpleEmployees: [EmployeeUiModel] = [
        EmployeeUiModel(
            id: "AM",
            name: "Ahmad Mohammad",
            position: "Division Head",
            location: "Sheikh Zayed St., Dubai, UAE",
            color: Color(red: 0.957, green: 0.263, blue: 0.212), // #FFF44336
            children: [
                EmployeeUiModel(
                    id: "MM",
                    name: "Mazen Mohammad",
                    position: "Office Manager",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 1.0, green: 0.922, blue: 0.231), // #FFFFEB3B
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Ahmed El-Ahmady",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.612, green: 0.153, blue: 0.69), // #FF9C27B0
                            children: [
                                EmployeeUiModel(
                                    id: "AE",
                                    name: "Mina Samir",
                                    position: "Employee",
                                    location: "Sheikh Zayed St., Dubai, UAE",
                                    color: Color(red: 0.451, green: 0.522, blue: 0.973), // #FF7385F8
                                    children: [
                                        EmployeeUiModel(
                                            id: "AE",
                                            name: "Mina Samir 2",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.435, green: 0.451, blue: 0.541), // #FF6F738A
                                            children: [
                                                EmployeeUiModel(
                                                    id: "AE",
                                                    name: "Mina Samir 4",
                                                    position: "Employee",
                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                    color: Color(red: 0.306, green: 0.635, blue: 0.78) // #FF4EA2C7
                                                ),
                                                EmployeeUiModel(
                                                    id: "MA",
                                                    name: "Kaylee Mina 4",
                                                    position: "Employee",
                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                    color: Color(red: 0.412, green: 0.757, blue: 0.91) // #FF69C1E8
                                                )
                                            ]
                                        ),
                                        EmployeeUiModel(
                                            id: "MA",
                                            name: "Kaylee Mina 2",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 1.0, green: 0.0, blue: 0.867) // #FFFF00DD
                                        )
                                    ]
                                ),
                                EmployeeUiModel(
                                    id: "MA",
                                    name: "Kaylee Mina",
                                    position: "Employee",
                                    location: "Sheikh Zayed St., Dubai, UAE",
                                    color: Color(red: 1.0, green: 0.596, blue: 0.0), // #FFFF9800
                                    children: [
                                        EmployeeUiModel(
                                            id: "AE",
                                            name: "Mina Samir 3",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.016, green: 0.039, blue: 0.184) // #FF040A2F
                                        ),
                                        EmployeeUiModel(
                                            id: "MA",
                                            name: "Kaylee Mina 3",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.882, green: 0.231, blue: 0.459) // #FFE13B75
                                        )
                                    ]
                                )
                            ]
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Mohamed Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.404, green: 0.227, blue: 0.718) // #FF673AB7
                        )
                    ]
                ),
                EmployeeUiModel(
                    id: "MM2",
                    name: "Zena Amin",
                    position: "Marketing Specialist",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 0.247, green: 0.318, blue: 0.71), // #FF3F51B5
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Mohammed Mosaad",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.0, green: 0.737, blue: 0.831) // #FF00BCD4
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Amr Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.384, green: 0.898, blue: 0.392) // #FF62E564
                        )
                    ]
                ),
                EmployeeUiModel(
                    id: "MA",
                    name: "Nora Sayed",
                    position: "Employee",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 0.298, green: 0.686, blue: 0.314), // #FF4CAF50
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Behoy Melika",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.114, green: 0.18, blue: 0.624) // #FF1D2E9F
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Momen Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.584, green: 1.0, blue: 0.0) // #FF95FF00
                        )
                    ]
                )
            ]
        )
    ]
    static let complexEmployees: [EmployeeUiModel] = [
        EmployeeUiModel(
            id: "AM",
            name: "Ahmad Mohammad",
            position: "Division Head",
            location: "Sheikh Zayed St., Dubai, UAE",
            color: Color(red: 0.957, green: 0.263, blue: 0.212), // #FFF44336
            children: [
                EmployeeUiModel(
                    id: "MM",
                    name: "Mazen Mohammad",
                    position: "Office Manager",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 1.0, green: 0.922, blue: 0.231), // #FFFFEB3B
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Ahmed El-Ahmady",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.612, green: 0.153, blue: 0.69), // #FF9C27B0
                            children: [
                                EmployeeUiModel(
                                    id: "AE",
                                    name: "Mina Samir",
                                    position: "Employee",
                                    location: "Sheikh Zayed St., Dubai, UAE",
                                    color: Color(red: 0.451, green: 0.522, blue: 0.973), // #FF7385F8
                                    children: [
                                        EmployeeUiModel(
                                            id: "AE",
                                            name: "Mina Samir 2",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.435, green: 0.451, blue: 0.541), // #FF6F738A
                                            children: [
                                                EmployeeUiModel(
                                                    id: "AE",
                                                    name: "Mina Samir 4",
                                                    position: "Employee",
                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                    color: Color(red: 0.306, green: 0.635, blue: 0.78), // #FF4EA2C7
                                                    children: [
                                                        EmployeeUiModel(
                                                            id: "AE",
                                                            name: "Mina Samir 5",
                                                            position: "Employee",
                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                            color: Color(red: 0.133, green: 0.208, blue: 0.69) // #FF2235B0
                                                        ),
                                                        EmployeeUiModel(
                                                            id: "MA",
                                                            name: "Kaylee Mina r",
                                                            position: "Employee",
                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                            color: Color(red: 0.502, green: 0.333, blue: 0.082), // #FF805515
                                                            children: [
                                                                EmployeeUiModel(
                                                                    id: "AE",
                                                                    name: "Mina Samir 6",
                                                                    position: "Employee",
                                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                                    color: Color(red: 0.58, green: 0.533, blue: 0.078), // #FF948814
                                                                    children: [
                                                                        EmployeeUiModel(
                                                                            id: "AE",
                                                                            name: "Mina Samir 7",
                                                                            position: "Employee",
                                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                                            color: Color(red: 0.58, green: 0.533, blue: 0.078), // #FF948814
                                                                            children: [
                                                                                EmployeeUiModel(
                                                                                    id: "AE",
                                                                                    name: "Mina Samir 9",
                                                                                    position: "Employee",
                                                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                                                    color: Color(red: 0.58, green: 0.533, blue: 0.078) // #FF948814
                                                                                ),
                                                                                EmployeeUiModel(
                                                                                    id: "MA",
                                                                                    name: "Kaylee Mina 9",
                                                                                    position: "Employee",
                                                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                                                    color: Color(red: 0.937, green: 0.855, blue: 0.106) // #FFEFDA1B
                                                                                )
                                                                            ]
                                                                        ),
                                                                        EmployeeUiModel(
                                                                            id: "MA",
                                                                            name: "Kaylee Mina 7",
                                                                            position: "Employee",
                                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                                            color: Color(red: 0.937, green: 0.855, blue: 0.106) // #FFEFDA1B
                                                                        )
                                                                    ]
                                                                ),
                                                                EmployeeUiModel(
                                                                    id: "MA",
                                                                    name: "Kaylee Mina 6",
                                                                    position: "Employee",
                                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                                    color: Color(red: 0.937, green: 0.855, blue: 0.106), // #FFEFDA1B
                                                                    children: [
                                                                        EmployeeUiModel(
                                                                            id: "AE",
                                                                            name: "Mina Samir 8",
                                                                            position: "Employee",
                                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                                            color: Color(red: 0.58, green: 0.533, blue: 0.078) // #FF948814
                                                                        ),
                                                                        EmployeeUiModel(
                                                                            id: "MA",
                                                                            name: "Kaylee Mina 8",
                                                                            position: "Employee",
                                                                            location: "Sheikh Zayed St., Dubai, UAE",
                                                                            color: Color(red: 0.937, green: 0.855, blue: 0.106) // #FFEFDA1B
                                                                        )
                                                                    ]
                                                                )
                                                            ]
                                                        )
                                                    ]
                                                ),
                                                EmployeeUiModel(
                                                    id: "MA",
                                                    name: "Kaylee Mina 4",
                                                    position: "Employee",
                                                    location: "Sheikh Zayed St., Dubai, UAE",
                                                    color: Color(red: 0.412, green: 0.757, blue: 0.91) // #FF69C1E8
                                                )
                                            ]
                                        ),
                                        EmployeeUiModel(
                                            id: "MA",
                                            name: "Kaylee Mina 2",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 1.0, green: 0.0, blue: 0.867) // #FFFF00DD
                                        )
                                    ]
                                ),
                                EmployeeUiModel(
                                    id: "MA",
                                    name: "Kaylee Mina",
                                    position: "Employee",
                                    location: "Sheikh Zayed St., Dubai, UAE",
                                    color: Color(red: 1.0, green: 0.596, blue: 0.0), // #FFFF9800
                                    children: [
                                        EmployeeUiModel(
                                            id: "AE",
                                            name: "Mina Samir 3",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.016, green: 0.039, blue: 0.184) // #FF040A2F
                                        ),
                                        EmployeeUiModel(
                                            id: "MA",
                                            name: "Kaylee Mina 3",
                                            position: "Employee",
                                            location: "Sheikh Zayed St., Dubai, UAE",
                                            color: Color(red: 0.882, green: 0.231, blue: 0.459) // #FFE13B75
                                        )
                                    ]
                                )
                            ]
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Mohamed Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.404, green: 0.227, blue: 0.718) // #FF673AB7
                        )
                    ]
                ),
                EmployeeUiModel(
                    id: "MM2",
                    name: "Zena Amin",
                    position: "Marketing Specialist",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 0.247, green: 0.318, blue: 0.71), // #FF3F51B5
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Mohammed Mosaad",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.0, green: 0.737, blue: 0.831) // #FF00BCD4
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Amr Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.384, green: 0.898, blue: 0.392) // #FF62E564
                        )
                    ]
                ),
                EmployeeUiModel(
                    id: "MA",
                    name: "Nora Sayed",
                    position: "Employee",
                    location: "Sheikh Zayed St., Dubai, UAE",
                    color: Color(red: 0.298, green: 0.686, blue: 0.314), // #FF4CAF50
                    children: [
                        EmployeeUiModel(
                            id: "AE",
                            name: "Behoy Melika",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.114, green: 0.18, blue: 0.624) // #FF1D2E9F
                        ),
                        EmployeeUiModel(
                            id: "MA",
                            name: "Momen Ahmed",
                            position: "Employee",
                            location: "Sheikh Zayed St., Dubai, UAE",
                            color: Color(red: 0.584, green: 1.0, blue: 0.0) // #FF95FF00
                        )
                    ]
                )
            ]
        )
    ]
}

// MARK: - Color Extensions for easier conversion

extension Color {
    // Convenience initializer for hex colors (similar to Android's Color(0xFF2196F3))
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

// Alternative: Use the new Color(hex:) initializer
// Color(hex: 0xFF2196F3)
