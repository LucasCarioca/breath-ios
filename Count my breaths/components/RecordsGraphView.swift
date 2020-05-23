//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct RecordsGraphView: View {
    var countRecords: FetchedResults<CountRecord>

    var body: some View {
        LineView(data: getBpmList(countRecords: countRecords))
    }

    func getBpmList(countRecords: FetchedResults<CountRecord>) -> [Double] {
        var list: [Double] = []
        for record in countRecords{
            list.append(Double(record.beats * 2))
        }
        return list.reversed()
    }
}