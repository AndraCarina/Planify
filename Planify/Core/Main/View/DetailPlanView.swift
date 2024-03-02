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
    @ObservedObject var viewModel = DetailPlanViewModel()
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
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    path = NavigationPath()
                } label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(colorScheme == .dark ? Color(UIColor.black) : Color(UIColor.white))
                            .scaleEffect(1.5)
                            .opacity(0.7)
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    VStack {
                        Button {
                            viewModel.markTripFinished(trip: trip)
                            path = NavigationPath()
                        } label: {
                            Text("Mark as finished")
                        }
                        
                        Button(role: .destructive){
                            path = NavigationPath()
                        } label: {
                            Text("Delete trip")
                        }
                    }
                } label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(colorScheme == .dark ? Color(UIColor.black) : Color(UIColor.white))
                            .scaleEffect(3)
                            .opacity(0.7)
                        Image(systemName: "ellipsis")
                            .foregroundStyle(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    }
                }
            }
        }
    }
}

#Preview {
    DetailPlanView(trip: TripModel(id: "123", userId: "123", name: "Barcelona Fun", location: "Barcelona, Spain", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: "02.03.2024", endDate: "03.03.2024", isFinished: "false"), path: .constant(NavigationPath()))
}
