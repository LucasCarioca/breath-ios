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

    @State var pickerSelectedItem = 0
    var body: some View {
        VStack {
            Text("History").Heading(size: .H5)
            SwitcherView(pages: [
                SwitcherPage(label: "List", view: RecordsListView()),
                SwitcherPage(label: "Graph", view: RecordsGraphView())
            ])
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
