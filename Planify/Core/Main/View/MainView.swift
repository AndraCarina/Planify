//
//  SignedInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        switch tab {
                        case .gearshape: SettingsView().tag(tab)
                        default: HStack {
                                    Image(systemName: tab.rawValue)
                                    Text("\(tab.rawValue.capitalized)")
                                        .bold()
                                        .animation(nil, value: selectedTab)
                                }
                        }
                    }
                }
            }
            VStack {
                Spacer()
                CustomTabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    MainView()
}
