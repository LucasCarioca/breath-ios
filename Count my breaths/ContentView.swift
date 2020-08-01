//
//  ContentView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents
import StoreKit

struct ContentView: View {

    @ObservedObject var viewRouter = ViewRouter()

    @State var showPopUp = false

    init() {
        let userDefaults = UserDefaults.standard
        let appRuns = userDefaults.integer(forKey: "appruns")
        let countRuns = userDefaults.integer(forKey: "countruns")
        let reviewShown = userDefaults.bool(forKey: "reviewshown")
        if (appRuns >= 5 || countRuns >= 5) && !reviewShown {
            SKStoreReviewController.requestReview()
            userDefaults.set(true, forKey: "reviewshown")
        }
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.viewRouter.currentView == "counter" {
                    CountView().padding(.horizontal)
                } else if self.viewRouter.currentView == "history" {
                    HistoryView().padding(.horizontal)
                } else if self.viewRouter.currentView == "info" {
                    InfoView().padding(.horizontal)
                }
                Spacer()
                ZStack {
                    HStack {
                        Image(systemName: "timer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                                .foregroundColor(self.viewRouter.currentView == "counter" ? .blue : .gray)
                                .onTapGesture {
                                    self.viewRouter.currentView = "counter"
                                }
                        Image(systemName: "chart.bar.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                                .foregroundColor(self.viewRouter.currentView == "history" ? .blue : .gray)
                                .onTapGesture {
                                    self.viewRouter.currentView = "history"
                                }
                        Image(systemName: "info.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                                .foregroundColor(self.viewRouter.currentView == "info" ? .blue : .gray)
                                .onTapGesture {
                                    self.viewRouter.currentView = "info"
                                }
                    }
                            .frame(width: geometry.size.width, height: geometry.size.height / 10).padding(.bottom)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
