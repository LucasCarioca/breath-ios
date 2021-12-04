//
// Created by Lucas Desouza on 12/3/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct CurrentPetView: View {
    var onRefresh: () -> Void
    var label: ((String) -> AnyView)?
    @State var refreshId = UUID()
    var body: some View {
        NavigationLink(destination: PetSelectionListView().onDisappear(perform: refresh)) {
            getLabel()
        }.id(refreshId)
    }

    func getLabel() -> AnyView {
        let petName = UserDefaults.standard.string(forKey: "CURRENT_PET") ?? "No pet selected"
        if let label = label {
            return label(petName)
        } else {
            return AnyView(Text("Selected Pet: \(petName)"))
        }
    }

    func refresh() {
        onRefresh()
        refreshId = UUID()
    }
}