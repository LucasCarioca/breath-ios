//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct RecordsListView: View {
    var countRecords: FetchedResults<CountRecord>

    init(countRecords: FetchedResults<CountRecord>){
        self.countRecords = countRecords
        UITableView.appearance().separatorStyle = .none
    }
    var body: some View {
        VStack {
            List {
                ForEach(countRecords.indices) { record in
                    RecordView(beats: self.countRecords[record].beats, timeText: self.countRecords[record].timeText ?? "unknown")
                }
            }
            MailButtonView(csvData: getCsvData())
        }
    }

    func getCsvData() -> Data? {
        let records = countRecords.sorted { a, b in return a.time! > b.time! }
        let recordService = RecordService(records: records)
        return recordService.exportCsvData()
    }
}
