//
//  PlansView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct PlansView: View {
    @ObservedObject private var tripManager = TripManager.shared

    var body: some View {
        VStack {
            ForEach(tripManager.trips) { trip in
                Text("\(trip.id)")
            }
        }
    }
}

#Preview {
    PlansView()
}
