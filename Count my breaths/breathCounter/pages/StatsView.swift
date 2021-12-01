//
// Created by Lucas Desouza on 8/20/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents
import SwiftUICharts
import CoreData

struct StatsView: View {
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository
    @State var petProfile = PetProfileController.loadPetProfile()
    @State var filter: QueryBy = .WEEK
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Total records")
                    Spacer()
                    Text("\(fetch().count)").fontWeight(.heavy)
                }
                HStack {
                    Text("High breathing rate")
                    Spacer()
                    Text("\(percentOverTarget())%").fontWeight(.heavy)
                }
                HStack {
                    Text("Average")
                    Spacer()
                    Text("\(average())").fontWeight(.heavy)
                }
                HStack {
                    Text("Highest")
                    Spacer()
                    Text("\(highest())").fontWeight(.heavy)
                }
                HStack {
                    Text("Lowest")
                    Spacer()
                    Text("\(lowest())").fontWeight(.heavy)
                }
                HStack {
                    Text("Median")
                    Spacer()
                    Text("\(median())").fontWeight(.heavy)
                }
                HStack {
                    Text("Most common")
                    Spacer()
                    Text("\(mode())").fontWeight(.heavy)
                }
            }.listStyle(PlainListStyle())
            Spacer()
            Picker(selection: self.$filter, label: Text("")) {
                Text("1w").tag(QueryBy.WEEK)
                Text("2w").tag(QueryBy.TWO_WEEKS)
                Text("1m").tag(QueryBy.MONTH)
                Text("6m").tag(QueryBy.SIX_MONTHS)
            }.pickerStyle(SegmentedPickerStyle())
        }.onAppear {
            self.petProfile = PetProfileController.loadPetProfile()
        }
    }

    func fetch() -> [CountRecord] {
        let range = getRange(filter)
        return countRecordRepository.getAllCountRecords(from: range.from, to: range.to)
    }

    func mode() -> Int {
        let bpmList = getBpmList()
        var counts = [Int: Int]()
        bpmList.forEach {
            counts[$0] = (counts[$0] ?? 0) + 1
        }
        if let (value, _) = counts.max(by: { $0.1 < $1.1 }) {
            return value
        }
        return 0
    }

    func getBpmList() -> [Int] {
        let countRecords = fetch()
        var bpmList: [Int] = []
        for record in countRecords {
            bpmList.append(Int(record.beats) * 2)
        }
        return bpmList.sorted()
    }

    func median() -> Int {
        let bpmList = getBpmList()
        if bpmList.count >= 1 {
            return bpmList.sorted(by: <)[bpmList.count / 2]
        }
        return 0
    }

    func lowest() -> Int {
        let bpmList = getBpmList()
        if bpmList.count >= 1 {
            return bpmList[0]
        }
        return 0
    }

    func highest() -> Int {
        let bpmList = getBpmList()
        if bpmList.count >= 1 {
            return bpmList[bpmList.count - 1]
        }
        return 0
    }

    func average() -> Int {
        let countRecords = fetch()
        if countRecords.count >= 1 {
            var total = 0
            for record in countRecords {
                total = total + (Int(record.beats) * 2)
            }
            return total / countRecords.count
        }
        return 0
    }

    func percentOverTarget() -> Int {
        let countRecords = getBpmList()
        if countRecords.count >= 1 {
            var total = 0
            for record in countRecords {
                if record >= petProfile.targetBpm {
                    total += 1
                }
            }
            return Int((CGFloat(total) / CGFloat(countRecords.count)) * 100)
        }
        return 0
    }


}
