//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct CountResults: View {
    var bpm: Int
    var body: some View {
        Text("Counted " + String(bpm) + " beats per minute.")
                .Paragraph(align: .center, size: .MD)
    }
}
