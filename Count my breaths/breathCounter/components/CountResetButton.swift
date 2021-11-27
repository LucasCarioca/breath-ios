//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct CountResetButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text("Reset")
        }.frame(height: 50).buttonStyle(SecondaryButton())
    }
}
