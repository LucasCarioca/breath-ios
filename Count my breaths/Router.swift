//
//  Router.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/20/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct Router: View {
    @Binding var selected: Routes?
    var body: some View {
        List {
            Section(header: Text("Breathing Tracker")) {
                NavigationLink(
                        destination:
                        CountView()
                                .padding()
                                .navigationBarTitle("Counter"),
                        tag: .counter,
                        selection: self.$selected) {
                    Label("Counter", systemImage: "lungs.fill")
                }
                NavigationLink(
                        destination:
                        HistoryView()
                                .padding()
                                .navigationBarTitle("History"),
                        tag: .history,
                        selection: self.$selected) {
                    Label("History", systemImage: "chart.bar.fill")
                }
            }
            Section(header: Text("Information")) {
                NavigationLink(
                        destination:
                        PetHealthView()
                                .navigationBarTitle("Pet health"),
                        tag: .info,
                        selection: self.$selected) {
                    Label("Pet health", systemImage: "heart.fill")
                }
                NavigationLink(
                        destination:
                        AboutUsView()
                                .navigationBarTitle("About us"),
                        tag: .about,
                        selection: self.$selected) {
                    Label("About us", systemImage: "info.circle.fill")
                }
            }
            Section(header: Text("Settings")) {
                NavigationLink(
                        destination:
                        PetListView()
                                .navigationBarTitle("Pets"),
                        tag: .profile,
                        selection: self.$selected) {
                    Label("Pets", systemImage: "person.crop.circle.fill")
                }
            }
        }
                .listStyle(GroupedListStyle())
    }
}

enum Routes: Equatable, Identifiable {
    case none
    case counter
    case history
    case pills
    case tracking
    case how
    case info
    case about
    case profile

    var id: Routes {
        self
    }
}
