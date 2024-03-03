//
//  PlanModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI

enum PlanType: String, Codable, CaseIterable {
    case food
    case transport
    case attraction
    case event
    
    var systemImage: String {
        switch self {
        case .food:
            return "fork.knife"
        case .transport:
            return "airplane"
        case .attraction:
            return "building.columns"
        case .event:
            return "party.popper"
        }
    }
    
    var typeName: String {
        switch self {
        case .food:
            return "Food"
        case .transport:
            return "Transport"
        case .attraction:
            return "Attraction"
        case .event:
            return "Event"
        }
    }
    
    var imageColor: Color {
        switch self {
        case .food:
            return Color.green
        case .transport:
            return Color.red
        case .attraction:
            return Color.blue
        case .event:
            return Color.pink
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
