//
//  BreathingTrackerRootView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import StoreKit
import QuickComponents

struct BreathingTrackerRootView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewRouter = BreathingTrackerViewRouter()
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
                }
                Spacer()
                ZStack {
                    HStack {
                        Image(systemName: "timer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                                .foregroundColor(self.viewRouter.currentView == "counter" ? Theme.colors.primary : Theme.colors.text)
                                .onTapGesture {
                                    withAnimation{
                                        self.viewRouter.currentView = "counter"
                                    }
                                }
                        Image(systemName: "chart.bar.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                                .foregroundColor(self.viewRouter.currentView == "history" ? Theme.colors.primary : Theme.colors.text)
                                .onTapGesture {
                                    withAnimation {
                                        self.viewRouter.currentView = "history"
                                    }
                                }
                    }
                            .frame(width: geometry.size.width, height: geometry.size.height / 10).padding(.bottom)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct BreathingTrackerRootView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingTrackerRootView()
    }
}
