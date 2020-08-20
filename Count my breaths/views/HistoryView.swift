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
                SwitcherPage(label: "List", view: SwitcherView(reverse:true, pages: [
                    SwitcherPage(label: "1w", view: ListView(by:.WEEK)),
                    SwitcherPage(label: "2w", view: ListView(by:.TWO_WEEKS)),
                    SwitcherPage(label: "1m", view: ListView(by:.MONTH)),
                    SwitcherPage(label: "6m", view: ListView(by:.SIX_MONTHS)),
                ])),
                SwitcherPage(label: "Graph", view: SwitcherView(reverse:true, pages: [
                    SwitcherPage(label: "1w", view: GraphView(by:.WEEK)),
                    SwitcherPage(label: "2w", view: GraphView(by:.TWO_WEEKS)),
                    SwitcherPage(label: "1m", view: GraphView(by:.MONTH)),
                    SwitcherPage(label: "6m", view: GraphView(by:.SIX_MONTHS)),
                ]))
            ])
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
