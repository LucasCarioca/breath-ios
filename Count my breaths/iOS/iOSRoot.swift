//
//  iOSRoot.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents

struct iOSRoot: View {
    
    @State var showMenu = false
    @State var showHelp = false
    @ObservedObject var viewRouter = RootViewRouter()
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    if self.viewRouter.currentView == "breathingTracker" {
                        BreathingTrackerRootView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false).navigationBarTitle("Breathing Tracker", displayMode: .inline)
                    } else if self.viewRouter.currentView == "info" {
                        InfoRootView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false).navigationBarTitle("Information", displayMode: .inline)
                    } else {
                        MainView(showMenu: self.$showMenu)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            .disabled(self.showMenu ? true : false)
                    }
                    if self.showMenu {
                        MenuView(viewRouter: self.viewRouter, showMenu: self.$showMenu)
                            .frame(width: geometry.size.width*0.90)
                            .transition(.move(edge: .leading))
                    }
                }
                    .gesture(drag)
            }
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 2).foregroundColor(.clear).frame(width: 40, height: 40)
                            Image(systemName: "line.horizontal.3").imageScale(.large)
                        }
                    }
                ), trailing: (
                    Button(action: {
                        withAnimation {
                            self.showHelp.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 2).foregroundColor(.clear).frame(width: 40, height: 40)
                            Image(systemName: "info").imageScale(.large)
                        }
                    }
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

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
               self.showMenu = true
            }
        }) {
            Text("Show Menu")
        }
    }
}

struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        iOSRoot()
    }
}
