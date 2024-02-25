//
//  TripListView.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import SwiftUI
import URLImage

struct TripListView: View {
    var trip: TripModel
    var body: some View {
        HStack {
            RemoteImageView(url: trip.photoURL)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
            
            VStack(alignment: .leading)
            {
                Text(trip.name)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(trip.location)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                Text(trip.startDate + "-" + trip.endDate)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

#Preview {
    TripListView(trip: TripModel(id: "id", userId: "userId", name: "Barcelona", location: "Barcelona", photoURL: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1467072114-656f160a0a37b.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*", startDate: "24.02.2024", endDate: "24.02.2024", isFinished: "false"))
}
