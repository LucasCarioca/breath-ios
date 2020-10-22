//
//  App.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import ToastUI
import StoreKit
import QuickComponents

@main
struct AppRoot: App {
    let persistenceController = PersistenceController.shared
    
    @State var showNewVersion = false
    @State var version = VersionController.loadVersion()
    @State var selected: Routes?
    
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
    
    var body: some Scene{
        WindowGroup {
            ZStack {
                Theme.colors.text.edgesIgnoringSafeArea(.all)
                NavigationView {
                    Router(selected: $selected)
                        .navigationBarTitle("Heyyyyoo")
                    
                    CountView()
                        .padding()
                        .navigationBarTitle("Counter")
                }
            }.onAppear {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    self.selected = .counter
                }
            }
                .toast(isPresented: $showNewVersion) {
                ToastView {
                    VStack {
                        Text("New Features v\(self.version.version) 🎉").Paragraph(align: .center, size: .LG)
                        ScrollView {
                            VStack {
                                Text(self.version.description).Paragraph(align: .center)
                                self.version.newFeatures.count >= 1 ? ForEach(0..<self.version.newFeatures.count) { index in
                                    Text(self.version.newFeatures[index]).Paragraph(align: .center)
                                } : nil
                            }
                        }.frame(maxHeight: 150)
                        Button(action: {
                            self.showNewVersion = false
                            self.version.isNew = false
                            VersionController.saveVersion(version: self.version)
                        }) {
                            Text("OK")
                        }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
                    }
                }.padding()
            }
            .onAppear() {
                if (self.version.isNew) {
                    self.showNewVersion = true
                }
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
