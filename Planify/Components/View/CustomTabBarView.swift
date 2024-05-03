//
//  MainTabView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTabIndex: Int
    let tabs: [TabModel]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(UIColor.lightGray))
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Spacer()
                    let tab = tabs[index]
                    let isSelected = selectedTabIndex == index
                    Image(systemName: isSelected ? tab.selectedImageName : tab.normalImageName)
                        .scaleEffect(isSelected ? 1.25 : 1.0)
                        .foregroundStyle(isSelected ? tab.selectedImageColor : Color(UIColor.lightGray))
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTabIndex = index
                            }
                        }
                    Spacer()
                }
            }
            .padding(.top, 5)
            .cornerRadius(10)
        }
    }
}

#Preview {
    CustomTabBarView(selectedTabIndex: .constant(0), tabs: [
        TabModel(normalImageName: "paperplane", selectedImageName: "paperplane.fill", selectedImageColor: .blue, selectedView: AnyView(UpcomingTripsView())),
        TabModel(normalImageName: "plus.app", selectedImageName: "plus.app.fill", selectedImageColor: .indigo, selectedView: AnyView(AddTripView())),
        TabModel(normalImageName: "gearshape", selectedImageName: "gearshape.fill", selectedImageColor: .orange, selectedView: AnyView(SettingsView())),
    ])
}
