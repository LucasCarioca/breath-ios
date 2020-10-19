//
//  iPadOSRoot.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct iPadOSRoot: View {
    @State var selected: NavigationPage = .counter

    var body: some View {
        NavigationView {
            SidebarView(selected: self.$selected)
            MainView(selected: self.$selected)
        }.navigationBarBackButtonHidden(true)
    }
    
    
}

struct SidebarView: View  {
    @Binding var selected: NavigationPage
    var body: some View {
        List {
            Section (header: Text("Breathing Tracker")) {
                Button(action: {
                    print(self.selected)
                    self.selected = .counter
                    print(self.selected)
                }, label: {
                    SideBarLabel("Counter", systemImage: "timer")
                })
                Button(action: {
                    print(self.selected)
                    self.selected = .history
                    print(self.selected)
                }, label: {
                    SideBarLabel("History", systemImage: "chart.bar.fill")
                })
            }
            Section(header: Text("Information")){
                Button(action: {
                    print(self.selected)
                    self.selected = .info
                    print(self.selected)
                }, label: {
                    SideBarLabel("Pet health", systemImage: "heart.fill")
                })
                Button(action: {
                    print(self.selected)
                    self.selected = .about
                    print(self.selected)
                }, label: {
                    SideBarLabel("Pet health", systemImage: "info.circle.fill")
                })
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selected: NavigationPage
    var body: some View {
        VStack {
            if selected == .counter {
                CountView()
                    .padding()
                    .padding(.top, 50)
                    .edgesIgnoringSafeArea(.all)
            } else if selected == .history {
                HistoryView()
                    .padding()
                    .padding(.top, 50)
                    .edgesIgnoringSafeArea(.all)
            } else if selected == .info {
                InfoView()
                    .padding()
                    .padding(.top, 50)
                    .edgesIgnoringSafeArea(.all)
            } else if selected == .about {
                AboutUsView()
                    .padding()
                    .padding(.top, 50)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct BackButton: View {
    var presentationMode : Binding<PresentationMode>

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }
}


