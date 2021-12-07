//
// Created by Lucas Desouza on 5/22/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import CoreData
import MessageUI

public class BreathRecordCSVBuilder {

    private var records: [CountRecord] = [];

    public func with(records: [CountRecord]) -> BreathRecordCSVBuilder {
        self.records = records
        return self
    }

    private func createHeader() -> String {
        "BPM, Date\n"
    }

    private func createRow(record: CountRecord) -> String {
        "\(String(record.beats * 2)), \(record.timeText!)\n"
    }

    public func buildCsv() -> String {
        var csvString = createHeader()
        for record in records {
            csvString = csvString + createRow(record: record)
        }
        return csvString
    }

    public func build() -> Data? {
        buildCsv().data(using: String.Encoding.utf8)
    }

}

