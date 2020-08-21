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
    @Environment(\.managedObjectContext) var moc
    @State var petProfile = PetProfileController.loadPetProfile()
    @State var filter: QueryBy = .WEEK
    var body: some View {
        VStack{
            List {
                HStack {
                    Text("Total records")
                    Spacer()
                    Text("\(self.fetch(by: self.filter).count)").fontWeight(.heavy)
                }
                HStack {
                    Text("Average")
                    Spacer()
                    Text("\(self.average())").fontWeight(.heavy)
                }
                HStack {
                    Text("Highest")
                    Spacer()
                    Text("\(self.highest())").fontWeight(.heavy)
                }
                HStack {
                    Text("Lowest")
                    Spacer()
                    Text("\(self.lowest())").fontWeight(.heavy)
                }
                HStack {
                    Text("Median")
                    Spacer()
                    Text("\(self.median())").fontWeight(.heavy)
                }
                HStack {
                    Text("Most common")
                    Spacer()
                    Text("\(self.mode())").fontWeight(.heavy)
                }
            }
            Spacer()
            Picker(selection: self.$filter, label: Text("")) {
                Text("1w").tag(QueryBy.WEEK)
                Text("2w").tag(QueryBy.TWO_WEEKS)
                Text("1m").tag(QueryBy.MONTH)
                Text("6m").tag(QueryBy.SIX_MONTHS)
            }.pickerStyle(SegmentedPickerStyle())
        }
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

    func mode() -> Int {
        let bpmList = getBpmList()
        var counts = [Int: Int]()
        bpmList.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            return value
        }
        return 0
    }

    func getBpmList() -> [Int] {
        let countRecords = fetch(by: filter)
        var bpmList: [Int] = []
        for record in countRecords {
            bpmList.append(Int(record.beats) * 2)
        }
        return bpmList.sorted()
    }

    func median() -> Int{
        let bpmList = getBpmList()
        if bpmList.count >= 1 {
            return bpmList.sorted(by: <)[bpmList.count / 2]
        }
        return 0
    }

    func lowest() -> Int{
        let bpmList = getBpmList()
        if bpmList.count >= 1{
            return bpmList[0]
        }
        return 0
    }

    func highest() -> Int{
        let bpmList = getBpmList()
        if bpmList.count >= 1{
            return bpmList[bpmList.count-1]
        }
        return 0
    }

    func average() -> Int{
        let countRecords = fetch(by: filter)
        if countRecords.count >= 1 {
            var total = 0
            for record in countRecords {
                total = total + (Int(record.beats) * 2)
            }
            return total/countRecords.count
        }
        return 0
    }


}