//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct CountHowTowPopOver: View {
    var action: () -> Void
    var body: some View {
        VStack {
            HowToView()
            Button(action: action) {
                Text("Close")
            }.buttonStyle(SecondaryButton()).frame(width: 100, height: 50)
        }.padding()
    }
}
