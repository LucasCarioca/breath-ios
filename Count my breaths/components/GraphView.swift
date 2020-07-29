//
// Created by Lucas Desouza on 6/14/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents
import SwiftUICharts
import CoreData

enum GraphBy {
    case MAX
    case WEEK
    case TWO_WEEKS
    case MONTH
    case SIX_MONTHS
}

struct GraphView: View {
    @Environment(\.managedObjectContext) var moc

    var by: GraphBy

    init () {
        self.by = .MAX
    }

    init (by: GraphBy) {
        self.by = by
    }

    var body: some View {
        LineView(data: getBpmList())
    }

    func fetch() -> [CountRecord] {
        var countRecords: [CountRecord]
        let request = requestBuilder(sort: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)])
        switch self.by {
            case .MAX:
                try! countRecords = self.moc.fetch(request)
            case .WEEK:
                try! countRecords = self.moc.fetch(query(days: 7, request: request))
            case .TWO_WEEKS:
                try! countRecords = self.moc.fetch(query(days: 14, request: request))
            case .MONTH:
                try! countRecords = self.moc.fetch(query(days: 30, request: request))
            case .SIX_MONTHS:
                try! countRecords = self.moc.fetch(query(days: 180, request: request))
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

    func getBpmList() -> [Double] {

        var list: [Double] = []
        for record in fetch(){
            list.append(Double(record.beats * 2))
        }
        return list.reversed()
    }
}

