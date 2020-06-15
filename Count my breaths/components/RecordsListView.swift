//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct RecordsListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: requestBuilder(limit: 100, sort: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)])) var countRecords: FetchedResults<CountRecord>

    init(){
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            List {
                ForEach(countRecords.indices, id: \.self) { record in
                    RecordView(beats: self.countRecords[record].beats, timeText: self.countRecords[record].timeText ?? "unknown")
                }.onDelete(perform: delete)
            }
            MailButtonView(csvData: getCsvData())
        }
    }

    func delete(at offsets: IndexSet) {
        print("deleting \(offsets.first!)")
        if let index = offsets.first {
            managedObjectContext.delete(countRecords[index])
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("error occurred trying to save to core data")
        }
    }

    func getCsvData() -> Data? {
        let records = countRecords.sorted { a, b in return a.time! > b.time! }
        let recordService = RecordService(records: records)
        return recordService.exportCsvData()
    }
}
