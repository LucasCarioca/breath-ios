//
//  MacOSRootRouter.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct MacOSRootRouter: View {
    @State var selected: NavigationPage? = .counter
    var body: some View {
        List {
            Section (header: Text("Breathing Tracker")) {
                NavigationLink(
                    destination:
                        CountView()
                            .padding()
                            .padding(.top, 50)
                            .edgesIgnoringSafeArea(.all),
                    tag: .counter,
                    selection: self.$selected) {
                    SideBarLabel("Counter", systemImage: "timer")
                }
                NavigationLink(
                    destination:
                        HistoryView()
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: .history,
                    selection: self.$selected) {
                    SideBarLabel("History", systemImage: "chart.bar.fill")
                }
            }
            Section(header: Text("Information")){
                NavigationLink(
                    destination:
                        VStack {
                            Text("Pet health").Heading(size: .H5)
                            PetHealthView()
                        }
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: .info,
                    selection: self.$selected) {
                    SideBarLabel("Pet health", systemImage: "heart.fill")
                }
                NavigationLink(
                    destination:
                        VStack {
                            Text("Pet health").Heading(size: .H5)
                            AboutUsView()
                        }
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: .about,
                    selection: self.$selected) {
                    SideBarLabel("Pet health", systemImage: "info.circle.fill")
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

    var id: NavigationPage { self }
}
