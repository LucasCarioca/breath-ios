//
// Created by Lucas Desouza on 5/22/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import CoreData
import MessageUI

public class RecordService {

    private let records: [CountRecord];

    init(records: [CountRecord]) {
        self.records = records
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

    public func exportCsvData() -> Data? {
        buildCsv().data(using: String.Encoding.utf8)
    }

}

