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
                        .navigationBarTitle("Menu")
                    
                    CountView()
                        .padding()
                        .navigationBarTitle("Counter")
                }
            }.onAppear {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    self.selected = .counter
                }
                if (self.version.isNew) {
                    self.showNewVersion = true
                }
            }.fullScreenCover(isPresented: self.$showNewVersion) {
                UpdateChangeView(
                    version: self.version.version,
                    versionDescription: self.version.description,
                    changes: self.version.newFeatures,
                    action: self.dismissNewVersionPopup
                )
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    func dismissNewVersionPopup() {
        self.showNewVersion = false
        self.version.isNew = false
        VersionController.saveVersion(version: self.version)
    }
}
