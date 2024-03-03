//
//  NavigationButtonView.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import SwiftUI

struct ToolbarButtonView: View {
    let imageName: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(colorScheme == .dark ? Color(UIColor.black) : Color(UIColor.white))
                .frame(width: 35, height: 35)
                .opacity(0.5)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                .frame(width: 20, height: 20)
        }
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        ToolbarButtonView(imageName: "ellipsis")
    }
}
