//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents

struct RecordView: View {
    var beats: Int16
    var timeText: String
    var targetBpm: Int

    var body: some View {
        VStack{
            BarView(
                value: CGFloat(beats * 2),
                max: CGFloat(targetBpm + 10),
                showLabel: true,
                color: ((beats * 2) >= targetBpm) ? Theme.colors.secondary : Theme.colors.primary)
                .padding(.top, 10)
                .padding(.bottom, 35)
            HStack {
                Text(timeText).font(.subheadline)
                Spacer()
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(beats: 20, timeText: "HelloWorld", targetBpm: 30)
    }
}
