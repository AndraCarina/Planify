//
//  PlansView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct TripsView: View {
    @State private var searchTerm = ""
    @State private var path = NavigationPath()
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var viewModel = TripsViewModel()

    var body: some View {
        NavigationStack(path: $path){	
            List {
                ForEach(viewModel.filteredTrips(searchTerm: searchTerm)) { trip in
                    TripListView(trip: trip)
                        .overlay {
                            NavigationLink(value: trip) {
                                TripListView(trip: trip)
                            }
                            .opacity(0)
                        }
                        .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15))
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
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(for: TripModel.self) {trip in
                TripView(trip: trip, path: $path)
            }
            
        }
    }
}

#Preview {
    TripsView()
}
