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
    let datasource: Datasource
    let countRecordRepository: CountRecordRepository
    let petRepository: PetRepository
    @State var showNewVersion = false
    @State var version = VersionController.loadVersion()
    @State var selected: Routes?

    init() {
        if CommandLine.arguments.contains("-test-data") {
            UserDefaults.standard.register(defaults: [
                "0001": true
            ])
            datasource = Datasource(inMemory: true)
        } else {
            datasource = Datasource(inMemory: false)
        }
        countRecordRepository = CountRecordRepository(ctx: datasource.getContainer().viewContext)
        petRepository = PetRepository(ctx: datasource.getContainer().viewContext)

        //temporary to migrate data from user defaults to core data
        petRepository.createFromDefault()

        let userDefaults = UserDefaults.standard
        let appRuns = userDefaults.integer(forKey: "appruns")
        let countRuns = userDefaults.integer(forKey: "countruns")
        let reviewShown = userDefaults.bool(forKey: "reviewshown")
        if (appRuns >= 5 || countRuns >= 5) && !reviewShown {
            SKStoreReviewController.requestReviewInCurrentScene()
            userDefaults.set(true, forKey: "reviewshown")
        }
        UITableView.appearance().backgroundColor = UIColor(red: 78 / 255, green: 78 / 255, blue: 78 / 255, alpha: 0.2)
        let path = FileManager
                .default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .last?
                .absoluteString
                .replacingOccurrences(of: "file://", with: "")
                .removingPercentEncoding

        print("Core Data DB Path :: \(path ?? "Not found")")
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                Router(selected: $selected)
                        .navigationBarTitle("Menu")
                CountView()
                        .padding()
                        .navigationBarTitle("Counter")
            }.onAppear {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            self.selected = .counter
                        }
                        if (version.isNew) {
                            self.showNewVersion = true
                        }
                    }.fullScreenCover(isPresented: self.$showNewVersion) {
                        UpdateChangeView(
                                version: version.version,
                                versionDescription: version.description,
                                changes: version.newFeatures,
                                action: dismissNewVersionPopup
                        )
                    }.environment(\.managedObjectContext, datasource.getContainer().viewContext)
                    .environment(\.countRecordRepository, countRecordRepository)
                    .environment(\.petRepository, petRepository)
        }
    }

    func dismissNewVersionPopup() {
        self.showNewVersion = false
        self.version.isNew = false
        VersionController.saveVersion(version: version)
    }
}
