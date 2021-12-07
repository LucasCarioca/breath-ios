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
    @Environment(\.petRepository) var petRepository: PetRepository

    @State var countRecords: [CountRecord] = []
    @State var filter: QueryBy = .WEEK
    @State var pet: Pet? = nil

    var body: some View {
        VStack {
            if countRecords.count > 0 {
                List {
                    ForEach(countRecords.indices, id: \.self) { record in
                        RecordView(beats: countRecords[record].beats, time: countRecords[record].time ?? Date(), targetBpm: getTargetBreathingRate())
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
            } else {
                Text("Breathing records are currently empty. Come back after you have taken some measurements.").Paragraph(align: .center, size: .MD)
                LottieView(filename: "empty")
            }
            MailButtonView(csvData: getCsvData(countRecords: countRecords))
            Picker(selection: self.$filter.onChange { by in
                self.countRecords = fetch()
            }, label: Text("")) {
                Text("1w").tag(QueryBy.WEEK)
                Text("2w").tag(QueryBy.TWO_WEEKS)
                Text("1m").tag(QueryBy.MONTH)
                Text("6m").tag(QueryBy.SIX_MONTHS)
            }.pickerStyle(SegmentedPickerStyle())
        }.onAppear {
            let name = UserDefaults.standard.string(forKey: "CURRENT_PET") ?? "MyPet"
            pet = petRepository.findByName(name)
            self.countRecords = fetch()
        }
    }

    func delete(at offsets: IndexSet) {
        print("deleting \(offsets.first!)")
        if let index = offsets.first {
            countRecordRepository.delete(countRecords[index])
        }
        self.countRecords = fetch()
    }

    func fetch() -> [CountRecord] {
        let range = getRange(filter)
        return countRecordRepository.getAllCountRecordsByPet(from: range.from, to: range.to, pet: pet).reversed()
    }

    func getTargetBreathingRate() -> Int {
        if let pet = pet {
            return Int(pet.targetBreathing)
        }
        return 30
    }
}
