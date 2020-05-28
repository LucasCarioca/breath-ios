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
                            Image(uiImage: UIImage(systemName: "timer")!)
                            Text("Counter")
                        }
                    }
                    .tag(0)
            HistoryView()
                    .padding()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage(systemName: "chart.bar.fill")!)
                            Text("History")
                        }
                    }
                    .tag(1)
            AccountView()
                    .padding()
                    .tabItem {
                        VStack {
                            Image(uiImage: UIImage(systemName: "person.circle.fill")!)
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
