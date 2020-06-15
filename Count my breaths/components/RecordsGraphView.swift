//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import SwiftUICharts
import QuickComponents

struct RecordsGraphView: View {

    var body: some View {
        SwitcherView(reverse:true, pages: [
            SwitcherPage(label: "1w", view: GraphView(by:.WEEK)),
            SwitcherPage(label: "2w", view: GraphView(by:.TWO_WEEKS)),
            SwitcherPage(label: "1m", view: GraphView(by:.MONTH)),
            SwitcherPage(label: "6m", view: GraphView(by:.SIX_MONTHS)),
        ])
    }
}
