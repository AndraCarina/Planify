//
//  PlansView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct UpcomingTripsView: View {
    @State private var searchTerm = ""
    @State private var path = NavigationPath()
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var viewModel = UpcomingTripsViewModel()

    var body: some View {
        NavigationStack(path: $path){	
            List {
                ForEach(viewModel.filteredTrips(searchTerm: searchTerm)) { trip in
                    NavigationLink(value: trip) {
                        TripListView(trip: trip)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let trip = viewModel.filteredTrips(searchTerm: searchTerm)[index]
                        viewModel.deleteTrip(trip: trip)
                    }
                })
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
            .navigationTitle("Upcoming trips")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(for: TripModel.self) {trip in
                UpcomingTripsDetailView(trip: trip, path: $path)
            }
            
        }
    }
}

#Preview {
    UpcomingTripsView()
}
