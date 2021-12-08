//
// Created by Lucas Desouza on 12/8/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct ManualRecordButton: View {
    var body: some View {
        VStack {
            NavigationLink(destination: ManualRecordForm()) {
                Label("Add a manual record", systemImage: "plus")
                        .padding()
                        .foregroundColor(Theme.colors.text)
                        .background(Color.accentColor)
                        .cornerRadius(5)
            }
        }
    }
}