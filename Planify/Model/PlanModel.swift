//
//  PlanModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation

enum PlanType: String, Codable, CaseIterable {
    case food
    case transport
    
    var systemImage: String {
        switch self {
        case .food:
            return "fork.knife"
        case .transport:
            return "airplane"
        }
    }
    
    var typeName: String {
        switch self {
        case .food:
            return "Food"
        case .transport:
            return "Transport"
        }
    }
}

struct PlanModel: Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let tripId: String
    let name: String
    let location: String
    let photoURL: String
    let startDate: Date
    let type: PlanType
}
