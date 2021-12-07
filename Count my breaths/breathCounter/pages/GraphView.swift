//
// Created by Lucas Desouza on 6/14/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents
import SwiftUICharts
import CoreData

enum QueryBy: Int {
    case MAX = 0
    case WEEK = 7
    case TWO_WEEKS = 14
    case MONTH = 30
    case SIX_MONTHS = 180
}

struct GraphView: View {
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository

    var filter: QueryBy

    init() {
        filter = .MAX
    }

    init(by: QueryBy) {
        filter = by
    }

    var body: some View {
        let records = getBpmList()
        if records.count > 1 {
            return AnyView(LineView(data: records))
        }
        return AnyView(VStack {
            Text("Before we can chart some graphs we need at least two measurements. Come back after you have taken some.").Paragraph(align: .center, size: .MD)
            LottieView(filename: "empty")
        })

    }

    func fetch() -> [CountRecord] {
        let range = getRange(filter)
        return countRecordRepository.getAllCountRecords(from: range.from, to: range.to).reversed()
    }

    func getBpmList() -> [Double] {
        var list: [Double] = []
        for record in fetch() {
            list.append(Double(record.beats * 2))
        }
        return list.reversed()
    }

}

