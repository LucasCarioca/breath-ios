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
    @State var refreshId = UUID()
    @State var pickerSelectedItem = 0
    var body: some View {
        VStack {
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                CurrentPetView(onRefresh: { refreshId = UUID() }, label: { name in
                    AnyView(Label("Selected pet: \(name)", systemImage: "checkmark.circle.fill"))
                })
            }
            SwitcherView(pages: [
                SwitcherPage(label: "List", view: ListView()),
                SwitcherPage(label: "Graph", view: SwitcherView(reverse: true, pages: [
                    SwitcherPage(label: "1w", view: GraphView(by: .WEEK)),
                    SwitcherPage(label: "2w", view: GraphView(by: .TWO_WEEKS)),
                    SwitcherPage(label: "1m", view: GraphView(by: .MONTH)),
                    SwitcherPage(label: "6m", view: GraphView(by: .SIX_MONTHS)),
                ])),
                SwitcherPage(label: "Stats", view: StatsView())
            ])
        }.id(refreshId)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
