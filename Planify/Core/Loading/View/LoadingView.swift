//
//  ProgressView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            Text("Loading")
        }
    }
}

#Preview {
    LoadingView()
}
