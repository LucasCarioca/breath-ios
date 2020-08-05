//
//  macOSRootView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import StoreKit
import QuickComponents

struct macOSRoot: View {
    @State var selected: NavigationPage? = .counter
    @State var showHelp: Bool = false
    init() {
        let userDefaults = UserDefaults.standard
        let appRuns = userDefaults.integer(forKey: "appruns")
        let countRuns = userDefaults.integer(forKey: "countruns")
        let reviewShown = userDefaults.bool(forKey: "reviewshown")
        if (appRuns >= 5 || countRuns >= 5) && !reviewShown {
            SKStoreReviewController.requestReview()
            userDefaults.set(true, forKey: "reviewshown")
        }
        UITableView.appearance().backgroundColor = UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 0.2)
    }
    var body: some View {
        ZStack {
            Theme.colors.text.edgesIgnoringSafeArea(.all)
            NavigationView {
                List {
                    Section (header: Text("Breathing Tracker")) {
                        NavigationLink(
                            destination:
                                CountView()
                                    .padding()
                                    .padding(.top, 50)
                                    .edgesIgnoringSafeArea(.all),
                            tag: .counter,
                            selection: $selected) {
                            SideBarLabel("Counter", systemImage: "timer")
                        }
                        NavigationLink(
                            destination:
                                HistoryView()
                                .padding()
                                .padding(.top, 50)
                                .edgesIgnoringSafeArea(.all),
                            tag: .history,
                            selection: $selected) {
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
                            selection: $selected) {
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
                            selection: $selected) {
                            SideBarLabel("Pet health", systemImage: "info.circle.fill")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarItems(trailing: (
                    Button(action: {
                        withAnimation {
                            self.showHelp.toggle()
                        }
                    }) {
                        Image(systemName: "info.circle").foregroundColor(.blue)
                    }.buttonStyle(PlainButtonStyle())
                ))
            }.sheet(isPresented: $showHelp) {
                VStack {
                    HowToView()
                    Button(action: {
                        self.showHelp = false
                    }) {
                        Text("Close")
                    }.buttonStyle(SecondaryButton()).frame(width: 100, height: 50)
                }.padding()
            }
        }
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

    struct SideBarLabel: View {
        var text: String
        var systemImage: String
        
        init(_ text: String, systemImage: String) {
            self.text = text
            self.systemImage = systemImage
        }
        
        var body: some View {
            HStack {
                Image(systemName: systemImage).resizable().frame(width: 25, height: 25)
                Text(text).Paragraph(size: .MD)
            }
        }
    }
