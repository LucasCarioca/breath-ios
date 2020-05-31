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
        if  (appRuns >= 5 || countRuns >= 5) && !reviewShown {
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
                            .frame(width: geometry.size.width/3, height: 75)
                            .foregroundColor(self.viewRouter.currentView == "counter" ? .blue : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "counter"
                            }
//                        ZStack {
//                            Circle()
//                                .foregroundColor(Color.white)
//                                .frame(width: 75, height: 75)
//                            Image(systemName: "plus.circle.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 75, height: 75)
//                                .foregroundColor(.blue)
//                                .rotationEffect(Angle(degrees: self.showPopUp ? 90 : 0))
//                        }
//                            .offset(y: -geometry.size.height/10/2)
//                            .onTapGesture {
//                                withAnimation {
//                                   self.showPopUp.toggle()
//                                }
//                            }
                        Image(systemName: "chart.bar.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: geometry.size.width/3, height: 75)
                            .foregroundColor(self.viewRouter.currentView == "history" ? .blue : .gray)
                            .onTapGesture {
                                self.viewRouter.currentView = "history"
                            }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/10).padding(.bottom)
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

struct PlusMenu: View {
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 70, height: 70)
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
            ZStack {
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 70, height: 70)
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
        }
            .transition(.scale)
    }
}
