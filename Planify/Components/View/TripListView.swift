//
//  TripListView.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import SwiftUI

struct TripListView: View {
    var trip: TripModel
    var body: some View {
        ZStack {
            RemoteImageView(url: trip.photoURL)
                .scaledToFill()
                .frame(height: 100)
                .clipped()
                .grayscale(trip.isFinished == "true" ? 1.0 : 0.0)
            
            VStack(alignment: .leading)
            {
                Text(trip.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 1)
            }
        }
    }
}

#Preview {
    TripListView(trip: TripModel(id: "id", userId: "userId", name: "Barcelona", location: "Barcelona", photoURL: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1467072114-656f160a0a37b.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*", startDate: Date.now, endDate: Date.now, isFinished: "false"))
}
