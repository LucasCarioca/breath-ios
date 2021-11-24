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
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository

    @State var petProfile = PetProfileController.loadPetProfile()
    @State var countRecords: [CountRecord] = []
    @State var filter: QueryBy = .WEEK

    var body: some View {
        VStack {
            List {
                ForEach(countRecords.indices, id: \.self) { record in
                    RecordView(beats: countRecords[record].beats, time: countRecords[record].time ?? Date(), targetBpm: petProfile.targetBpm)
                }.onDelete(perform: delete)
            }.listStyle(PlainListStyle())
            MailButtonView(csvData: getCsvData())
            Picker(selection: self.$filter.onChange { by in
                self.countRecords = fetch(by: by)
            }, label: Text("")) {
                Text("1w").tag(QueryBy.WEEK)
                Text("2w").tag(QueryBy.TWO_WEEKS)
                Text("1m").tag(QueryBy.MONTH)
                Text("6m").tag(QueryBy.SIX_MONTHS)
            }.pickerStyle(SegmentedPickerStyle())
        }.onAppear {
            self.petProfile = PetProfileController.loadPetProfile()
            countRecords = countRecordRepository.getAllBreathRecords()
//            self.countRecords = fetch(by: filter)
        }
    }

    func delete(at offsets: IndexSet) {
        print("deleting \(offsets.first!)")
        if let index = offsets.first {
            moc.delete(countRecords[index])
        }
        do {
            try moc.save()
            self.countRecords = fetch(by: filter)
        } catch {
            print("error occurred trying to save to core data")
        }
    }

    func getCsvData() -> Data? {
        let records = countRecords.sorted { a, b in
            a.time! > b.time!
        }
        let recordService = RecordService(records: records)
        return recordService.exportCsvData()
    }

    func fetch(by: QueryBy) -> [CountRecord] {
        var countRecords: [CountRecord] = []
        let request = requestBuilder(sort: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)])
        switch by {
        case .MAX:
            try? countRecords = moc.fetch(request)
        case .WEEK:
            try? countRecords = moc.fetch(query(days: 7, request: request))
        case .TWO_WEEKS:
            try? countRecords = moc.fetch(query(days: 14, request: request))
        case .MONTH:
            try? countRecords = moc.fetch(query(days: 30, request: request))
        case .SIX_MONTHS:
            try? countRecords = moc.fetch(query(days: 180, request: request))
        }
        return countRecords
    }

    func query(days: Int, request: NSFetchRequest<CountRecord>) -> NSFetchRequest<CountRecord> {
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
