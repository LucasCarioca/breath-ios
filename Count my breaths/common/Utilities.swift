//
// Created by Lucas Desouza on 11/24/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation

func getRange(_ range: QueryBy) -> (from: Date, to: Date) {
    let toDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
    return (Calendar.current.date(byAdding: DateComponents(day: -range.rawValue), to: toDate)!, toDate)
}

func getCsvData(countRecords: [CountRecord]) -> Data? {
    let records = countRecords.sorted { a, b in
        a.time! > b.time!
    }
    return BreathRecordCSVBuilder()
            .with(records: records)
            .build()
}