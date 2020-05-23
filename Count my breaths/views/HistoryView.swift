//
//  HistoryView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import CoreData
import QuickComponents

struct HistoryView: View {
    @FetchRequest(entity: CountRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)]) var countRecords: FetchedResults<CountRecord>
    @State var pickerSelectedItem = 0
    var body: some View {
        VStack {
            HeaderView(title: "History", subTitle: "Previous records will show up here.")
            SwitcherView(pages: [
                SwitcherPage(label: "List", view: RecordsListView(countRecords: countRecords)),
                SwitcherPage(label: "Graph", view: RecordsGraphView(countRecords: countRecords))
            ])
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
