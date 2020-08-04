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

#if targetEnvironment(macCatalyst)
struct ContentView: View {
    @State var selected: Int? = 0
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination:
                        CountView()
                            .padding()
                            .padding(.top, 50)
                            .edgesIgnoringSafeArea(.all),
                    tag: 0,
                    selection: $selected) {
                    SideBarLabel("Counter", systemImage: "info.circle.fill")
                }
                NavigationLink(
                    destination:
                        HistoryView()
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: 1,
                    selection: $selected) {
                    SideBarLabel("History", systemImage: "info.circle.fill")
                }
                NavigationLink(
                    destination:
                        VStack {
                            Text("How to use this app").Heading(size: .H5)
                            HowToView()
                        }
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: 2,
                    selection: $selected) {
                    SideBarLabel("How to use this App", systemImage: "info.circle.fill")
                }
                NavigationLink(
                    destination:
                        VStack {
                            Text("Pet health information").Heading(size: .H5)
                            PetHealthView()
                        }
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: 3,
                    selection: $selected) {
                    SideBarLabel("Pet health information", systemImage: "heart.fill")
                }
                NavigationLink(
                    destination:
                        VStack {
                            Text("About us").Heading(size: .H5)
                            AboutUsView()
                        }
                        .padding()
                        .padding(.top, 50)
                        .edgesIgnoringSafeArea(.all),
                    tag: 4,
                    selection: $selected) {
                    SideBarLabel("About us", systemImage: "face.smiling.fill")
                }
            }.listStyle(SidebarListStyle())
        }
    }
}
#else
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
#endif

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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
