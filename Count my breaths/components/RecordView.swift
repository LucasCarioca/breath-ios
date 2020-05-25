//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents

struct RecordView: View {
    var beats: Int16
    var timeText: String

    var body: some View {
        VStack{
            BarView(
                value: CGFloat(beats * 2),
                max: 40,
                showLabel: true,
                color: ((beats * 2) >= 30) ? .red : nil)
                    .padding(.bottom)
                    .padding(.top)
            HStack {
                Text(timeText).font(.subheadline)
                Spacer()
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(beats: 20, timeText: "HelloWorld")
    }
}
