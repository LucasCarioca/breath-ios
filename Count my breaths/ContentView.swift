//
//  ContentView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            CountView()
                .padding()
                .tabItem {
                    VStack {
                        Image(colorScheme == .dark ? "timer2w" : "timer2")
                        Text("Counter")
                    }
                }
                .tag(0)
            HistoryView()
                .padding()
                .tabItem {
                    VStack {
                        Image(colorScheme == .dark ? "chart2w" : "chart2")
                        Text("History")
                    }
                }
                .tag(1)
            AccountView()
                .padding()
                .tabItem {
                    VStack {
                        Image(colorScheme == .dark ? "account2w" : "account2")
                        Text("Account")
                    }
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
