//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct CountShowHelpButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 2).foregroundColor(.clear).frame(width: 40, height: 40)
                Image(systemName: "info.circle.fill").imageScale(.large)
            }
        }
    }
}
