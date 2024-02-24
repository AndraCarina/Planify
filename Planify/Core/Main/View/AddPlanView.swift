//
//  AddPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct AddPlanView: View {
    @ObservedObject var viewModel = AddPlanViewModel()

    var body: some View {
        VStack {
            Text("AddPlanView")
            Button {
                viewModel.addTrip()
            } label: {
                Text("Add trip")
            }
        }
    }
}

#Preview {
    AddPlanView()
}
