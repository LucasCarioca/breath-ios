//
//  MacOSRootRouter.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct MacOSRootRouter: View {
    @Binding var selected: NavigationPage?
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
                    SideBarLabel("Counter", systemImage: "timer")
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

enum NavigationPage: Equatable, Identifiable {
    case none
    case counter
    case history
    case pills
    case tracking
    case how
    case info
    case about
    case profile

    var id: NavigationPage { self }
}
