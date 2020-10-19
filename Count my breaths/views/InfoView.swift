//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents

struct InfoView: View {

    var body: some View {
        VStack {
            SwitcherView(pages: [
                SwitcherPage(label: "Using this app", view: HowToView()),
                SwitcherPage(label: "Pet Health", view: PetHealthView()),
                SwitcherPage(label: "AboutUs", view: AboutUsView())
            ])
            Spacer()
        }

    }
}
