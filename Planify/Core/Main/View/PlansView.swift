//
//  PlansView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

// Define static array with placeholder data
extension TripModel {
    static var sampleTrips: [TripModel] {
        return [
            TripModel(id: "1", userId: "user1", name: "Barcelona party", location: "Barcelona", photoURL: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1467072114-656f160a0a37b.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*", startDate: "01.01.2024", endDate: "02.01.2024", isFinished: "false"),
            TripModel(id: "2", userId: "user2", name: "Amsterdam fun", location: "Amsterdam", photoURL: "https://www.travelandleisure.com/thmb/lI6nagO4MS8iZ0XRg0GbnbtvKW8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-amsterdam-AMSTERDAMTGGHOG0823-a2f9a769f3c44a23b08649daf25e1c8c.jpg", startDate: "01.02.2024", endDate: "02.02.2024", isFinished: "true"),
            TripModel(id: "2", userId: "user2", name: "Amsterdam fun", location: "Amsterdam", photoURL: "https://www.travelandleisure.com/thmb/lI6nagO4MS8iZ0XRg0GbnbtvKW8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-amsterdam-AMSTERDAMTGGHOG0823-a2f9a769f3c44a23b08649daf25e1c8c.jpg", startDate: "01.02.2024", endDate: "02.02.2024", isFinished: "true"),
            TripModel(id: "2", userId: "user2", name: "Amsterdam fun", location: "Amsterdam", photoURL: "https://www.travelandleisure.com/thmb/lI6nagO4MS8iZ0XRg0GbnbtvKW8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-amsterdam-AMSTERDAMTGGHOG0823-a2f9a769f3c44a23b08649daf25e1c8c.jpg", startDate: "01.02.2024", endDate: "02.02.2024", isFinished: "true"),
            TripModel(id: "2", userId: "user2", name: "Amsterdam fun", location: "Amsterdam", photoURL: "https://www.travelandleisure.com/thmb/lI6nagO4MS8iZ0XRg0GbnbtvKW8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-amsterdam-AMSTERDAMTGGHOG0823-a2f9a769f3c44a23b08649daf25e1c8c.jpg", startDate: "01.02.2024", endDate: "02.02.2024", isFinished: "true"),
            TripModel(id: "2", userId: "user2", name: "Amsterdam fun", location: "Amsterdam", photoURL: "https://www.travelandleisure.com/thmb/lI6nagO4MS8iZ0XRg0GbnbtvKW8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/TAL-amsterdam-AMSTERDAMTGGHOG0823-a2f9a769f3c44a23b08649daf25e1c8c.jpg", startDate: "01.02.2024", endDate: "02.02.2024", isFinished: "true")
        ]
    }
}

import SwiftUI

struct PlansView: View {
    @State private var searchTerm = ""
    @State private var path = NavigationPath()
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var viewModel = PlansViewModel()

    var body: some View {
        NavigationStack(path: $path){	
            List {
                ForEach(viewModel.filteredTrips(searchTerm: searchTerm)) { trip in
                    NavigationLink {
                        DetailPlanView(trip: trip, path: $path)
                    } label: {
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
            .frame( maxWidth: .infinity)
            .listStyle(.plain)
            .navigationTitle("Upcoming trips")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

#Preview {
    PlansView()
}
