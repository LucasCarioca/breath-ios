//
// Created by Lucas Desouza on 8/19/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents
import SwiftUICharts
import CoreData


struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var petProfile = PetProfileController.loadPetProfile()
    @State var countRecords: [CountRecord] = []
    @State var filter: QueryBy = .WEEK
    var body: some View {
        VStack {
            List {
                ForEach(self.countRecords.indices, id: \.self) { record in
                    RecordView(beats: self.countRecords[record].beats, time: self.countRecords[record].time ?? Date(), targetBpm: self.petProfile.targetBpm)
                }.onDelete(perform: delete)
            }.listStyle(PlainListStyle())
            MailButtonView(csvData: getCsvData())
            Picker(selection: self.$filter.onChange { by in self.countRecords = self.fetch(by: by)  }, label: Text("")) {
                Text("1w").tag(QueryBy.WEEK)
                Text("2w").tag(QueryBy.TWO_WEEKS)
            }.pickerStyle(SegmentedPickerStyle())
        }.onAppear() {
            self.petProfile = PetProfileController.loadPetProfile()
            self.countRecords = self.fetch(by: self.filter)
        }
    }

    func delete(at offsets: IndexSet) {
        print("deleting \(offsets.first!)")
        if let index = offsets.first {
            moc.delete(self.countRecords[index])
        }
        do {
            try moc.save()
            self.countRecords = self.fetch(by: self.filter)
        } catch {
            print("error occurred trying to save to core data")
        }
    }

    func getCsvData() -> Data? {
        let records = self.countRecords.sorted { a, b in return a.time! > b.time! }
        let recordService = RecordService(records: records)
        return recordService.exportCsvData()
    }

    func fetch(by: QueryBy) -> [CountRecord] {
        var countRecords: [CountRecord] = []
        let request = requestBuilder(sort: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)])
        switch by {
        case .MAX:
            try? countRecords = self.moc.fetch(request)
        case .WEEK:
            try? countRecords = self.moc.fetch(query(days: 7, request: request))
        case .TWO_WEEKS:
            try? countRecords = self.moc.fetch(query(days: 14, request: request))
        case .MONTH:
            try? countRecords = self.moc.fetch(query(days: 30, request: request))
        case .SIX_MONTHS:
            try? countRecords = self.moc.fetch(query(days: 180, request: request))
        }
        return countRecords
    }

    func query(days: Int, request: NSFetchRequest<CountRecord> ) -> NSFetchRequest<CountRecord>  {
        let toDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
        let dayComp = DateComponents(day: -days)
        let fromDate = Calendar.current.date(byAdding: dayComp, to: toDate)!
        print(fromDate)
        print(toDate)
        request.predicate = NSPredicate(format: "(time >= %@) AND (time <= %@)", fromDate as NSDate, toDate as NSDate)
        return request
    }
}
