//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents

struct RecordView: View {
    var beats: Int16
    var time: Date
    var targetBpm: Int

    var body: some View {
        VStack {
            HStack {
                Text(getDate()).font(.custom("", size: 18))
                Spacer()
            }
            BarView(
                    value: CGFloat(beats * 2),
                    max: CGFloat(targetBpm + 10),
                    showLabel: true,
                    color: ((beats * 2) >= targetBpm) ? Theme.colors.secondary : Theme.colors.primary)
                    .frame(height: 50)
        }
    }

    func getDate() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy HH:mm"
        return dateFormatterPrint.string(from: self.time)
    }

}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(beats: 20, time: Date(), targetBpm: 30)
    }
}
