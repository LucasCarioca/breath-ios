//
//  iOSRoot.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents
import ToastUI

struct iOSRoot: View {

    @State var showMenu = false
    @State var showHelp = false
    @ObservedObject var viewRouter = RootRouterState()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RootRouter(currentView: viewRouter.currentView, width: geometry.size.width, height: geometry.size.height, showMenu: showMenu)
                    if self.showMenu {
                        MenuView(viewRouter: self.viewRouter, showMenu: self.$showMenu)
                                .frame(width: geometry.size.width * 0.90)
                                .transition(.move(edge: .leading))
                    }
                }
                .sheet(isPresented: self.$showHelp) {
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
        }
    }
}
