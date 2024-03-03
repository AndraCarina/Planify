//
//  SignedInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @SceneStorage("selectedTabIndex") var selectedTabIndex: Int = 0
    
    var tabs: [TabModel] = []
    
    init() {
        UITabBar.appearance().isHidden = true
        self.tabs = [
            TabModel(normalImageName: "paperplane", selectedImageName: "paperplane.fill", selectedImageColor: .blue, selectedView: AnyView(UpcomingTripsView())),
            TabModel(normalImageName: "magnifyingglass.circle", selectedImageName: "magnifyingglass.circle.fill", selectedImageColor: .green, selectedView: AnyView(SuggestionView())),
            TabModel(normalImageName: "plus.app", selectedImageName: "plus.app.fill", selectedImageColor: .indigo, selectedView: AnyView(AddTripView())),
            TabModel(normalImageName: "archivebox", selectedImageName: "archivebox.fill", selectedImageColor: .red, selectedView: AnyView(ArchivedTripsView())),
            TabModel(normalImageName: "gearshape", selectedImageName: "gearshape.fill", selectedImageColor: .orange, selectedView: AnyView(SettingsView())),
        ]
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTabIndex) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        tabs[index].selectedView
                            .tag(index)
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBarView(selectedTabIndex: $selectedTabIndex, tabs: tabs)
                    .background(colorScheme == .dark ? Color(.black) : Color(.white))
            }
        }
    }
}

#Preview {
    MainView()
}
