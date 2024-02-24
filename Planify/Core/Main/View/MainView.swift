//
//  SignedInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

let tabs: [TabModel] = [
    TabModel(normalImageName: "paperplane", selectedImageName: "paperplane.fill", selectedImageColor: .blue, selectedView: AnyView(PlansView())),
    TabModel(normalImageName: "magnifyingglass.circle", selectedImageName: "magnifyingglass.circle.fill", selectedImageColor: .green, selectedView: AnyView(SuggestionView())),
    TabModel(normalImageName: "plus.app", selectedImageName: "plus.app.fill", selectedImageColor: .indigo, selectedView: AnyView(AddPlanView())),
    TabModel(normalImageName: "archivebox", selectedImageName: "archivebox.fill", selectedImageColor: .red, selectedView: AnyView(HistoryView())),
    TabModel(normalImageName: "gearshape", selectedImageName: "gearshape.fill", selectedImageColor: .orange, selectedView: AnyView(SettingsView())),
]

struct MainView: View {
    @State private var selectedTabIndex: Int = 0
    
    init() {
        UITabBar.appearance().isHidden = true
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
            }
        }
    }
}

#Preview {
    MainView()
}
