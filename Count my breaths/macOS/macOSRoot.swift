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
                MacOSRootRouter()
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


