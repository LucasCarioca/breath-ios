//
//  MenuView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewRouter: RootRouterState
    @Binding var showMenu: Bool
    var body: some View {
        VStack(alignment: .leading) {
            MenuItem(label: "Breathing Tracker", iconName: "lungs.fill", page: "breathingTracker", currentPage: viewRouter.currentView)
            .onTapGesture() {
                self.navigateTo(page: "breathingTracker")
            }.padding(.top, 75)
            MenuItem(label: "Information", iconName: "info.circle.fill", page: "info", currentPage: viewRouter.currentView)
            .onTapGesture() {
                self.navigateTo(page: "info")
            }
            MenuItem(label: "Pet Profile", iconName: "heart.circle.fill", page: "petprofile", currentPage: viewRouter.currentView)
            .onTapGesture() {
                self.navigateTo(page: "petprofile")
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.colors.background)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func navigateTo(page: String) {
        withAnimation {
            self.viewRouter.currentView = page
            self.showMenu.toggle()
        }
    }
}

struct MenuItem: View {
    var label: String
    var iconName: String
    var page: String
    var currentPage: String
    var body: some View {
        HStack {
            Image(systemName: iconName).resizable().frame(width: 40, height: 40)
                .foregroundColor(buttonColor())
            Text(label)
                .foregroundColor(buttonColor())
                .font(.headline)
        }.padding(.top, 20)
    }
    func buttonColor() -> Color{
        currentPage == page ? Theme.colors.primary : Theme.colors.text
    }
}

