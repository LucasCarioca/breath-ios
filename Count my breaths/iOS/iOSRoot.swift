//
//  iOSRoot.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct iOSRoot: View {
    @State var selected: RootPages? = .breathingTracker
    init(){
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(hexString: Theme.colors.backgroundRaw)
    }
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BreathingTrackerRootView(), tag: .breathingTracker, selection: $selected) {
                    Text("Breathing Tracker").foregroundColor(Theme.colors.text)
                }.listRowBackground(Theme.colors.background)
                NavigationLink(destination: InfoRootView().padding(), tag: .info, selection: $selected) {
                    Text("Information").foregroundColor(Theme.colors.text)
                }.listRowBackground(Theme.colors.background)
            }
        }
    }
}

struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        iOSRoot()
    }
}
