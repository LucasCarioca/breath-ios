//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct RecordView: View {
    var beats: Int16
    var timeText: String

    var body: some View {
        VStack{
            HStack {
                BarView(value: beats * 2)
                Spacer()
            }
            HStack {
                Text(timeText).font(.subheadline)
                Spacer()
            }
        }
    }
}