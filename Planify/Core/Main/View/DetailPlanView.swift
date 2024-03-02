//
//  DetailPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import SwiftUI

struct DetailPlanView: View {
    let trip: TripModel
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            RemoteImageView(url: trip.photoURL)
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .clipped()
            
            Text(trip.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Text(trip.location)
                .font(.subheadline)
            
            Text(trip.startDate + "-" + trip.endDate)
                .font(.subheadline)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DetailPlanView(trip: TripModel(id: "123", userId: "123", name: "Barcelona Fun", location: "Barcelona, Spain", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: "02.03.2024", endDate: "03.03.2024", isFinished: "false"), path: .constant(NavigationPath()))
}
