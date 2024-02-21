//
//  LoadingView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct StartView: View {
    @State private var isLoadingDone: Bool = false
    var body: some View {
        VStack {
            if isLoadingDone {
                MainView()
            } else {
                LoadingView().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoadingDone.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    StartView()
}
