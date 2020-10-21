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
                    SideBarLabel("Counter", systemImage: "lungs.fill")
                }
                NavigationLink(
                    destination:
                        HistoryView()
                            .padding()
                            .navigationBarTitle("History"),
                    tag: .history,
                    selection: self.$selected) {
                    SideBarLabel("History", systemImage: "chart.bar.fill")
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
                    SideBarLabel("Pet health", systemImage: "heart.fill")
                }
                NavigationLink(
                    destination:
                        AboutUsView()
                            .padding()
                            .navigationBarTitle("About us"),
                    tag: .about,
                    selection: self.$selected) {
                    SideBarLabel("About us", systemImage: "info.circle.fill")
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
                    SideBarLabel("Pet profile", systemImage: "person.crop.circle.fill")
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
