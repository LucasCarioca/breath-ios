//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct CountButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            GeometryReader { geometry in
                Image("icon")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color(red: 78 / 255, green: 78 / 255, blue: 78 / 255))
                        .cornerRadius(20)
            }
        }.accessibility(label: Text("Start counting")).buttonStyle(PlainButtonStyle())
    }
}
