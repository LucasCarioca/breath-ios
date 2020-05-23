//
//  HistoryView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import CoreData
import MessageUI

struct HistoryView: View {
    @FetchRequest(entity: CountRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)]) var countRecords: FetchedResults<CountRecord>
    @State var pickerSelectedItem = 0
    var body: some View {
        VStack {
            HeaderView(title: "History", subTitle: "Previous records will show up here.")
            Picker(selection: $pickerSelectedItem, label: Text("")) {
                Text("List").tag(0)
                Text("Graph").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            if pickerSelectedItem == 0 {
                RecordsListView(countRecords: countRecords)
            }
            else if pickerSelectedItem == 1 {
                RecordsGraphView(countRecords: countRecords)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
