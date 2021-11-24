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
        LineView(data: getBpmList())
    }

    func fetch() -> [CountRecord] {
        let range = getRange(filter)
        return countRecordRepository.getAllCountRecords(from: range.from, to: range.to)
    }

    func getBpmList() -> [Double] {
        var list: [Double] = []
        for record in fetch() {
            list.append(Double(record.beats * 2))
        }
        return list.reversed()
    }

}

