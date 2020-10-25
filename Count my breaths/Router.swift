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
            Section (header: Text("Breathing Tracker")) {
                NavigationLink(
                    destination:
                        CountView()
                            .padding()
                            .navigationBarTitle("Counter"),
                    tag: .counter,
                    selection: self.$selected) {
                    Label("Counter", systemImage: "lungs.fill")
                        .accessibility(label: Text("Counter"))
                }
                NavigationLink(
                    destination:
                        HistoryView()
                            .padding()
                            .navigationBarTitle("History"),
                    tag: .history,
                    selection: self.$selected) {
                    Label("History", systemImage: "chart.bar.fill")
                        .accessibility(label: Text("History"))
                }
            }
            Section(header: Text("Information")){
                NavigationLink(
                    destination:
                        PetHealthView()
                            .padding()
                            .navigationBarTitle("Pet health"),
                    tag: .info,
                    selection: self.$selected) {
                    Label("Pet health", systemImage: "heart.fill")
                }
                NavigationLink(
                    destination:
                        AboutUsView()
                            .padding()
                            .navigationBarTitle("About us"),
                    tag: .about,
                    selection: self.$selected) {
                    Label("About us", systemImage: "info.circle.fill")
                }
            }
            Section(header: Text("Settings")){
                NavigationLink(
                    destination:
                        PetProfileView()
                            .padding()
                            .navigationBarTitle("Pet profile"),
                    tag: .profile,
                    selection: self.$selected) {
                    Label("Pet profile", systemImage: "person.crop.circle.fill")
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

    var id: Routes
    { self }
}
