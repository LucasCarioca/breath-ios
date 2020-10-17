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
            HStack {
                Image(systemName: "timer").resizable().frame(width: 40, height: 35)
                    .foregroundColor(self.viewRouter.currentView == "breathingTracker" ? Theme.colors.primary : Theme.colors.text)
                Text("Breathing Tracker")
                    .foregroundColor(self.viewRouter.currentView == "breathingTracker" ? Theme.colors.primary : Theme.colors.text)
                    .font(.headline)
            }.onTapGesture() {
                self.navigateTo(page: "breathingTracker")
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "info.circle").resizable().frame(width: 40, height: 40)
                    .foregroundColor(self.viewRouter.currentView == "info" ? Theme.colors.primary : Theme.colors.text)
                Text("Information")
                    .foregroundColor(self.viewRouter.currentView == "info" ? Theme.colors.primary : Theme.colors.text)
                    .font(.headline)
            }.onTapGesture() {
                self.navigateTo(page: "info")
            }
                .padding(.top, 30)
            HStack {
                Image(systemName: "heart.circle.fill").resizable().frame(width: 40, height: 40)
                    .foregroundColor(self.viewRouter.currentView == "petprofile" ? Theme.colors.primary : Theme.colors.text)
                Text("Pet Profile")
                    .foregroundColor(self.viewRouter.currentView == "petprofile" ? Theme.colors.primary : Theme.colors.text)
                    .font(.headline)
            }.onTapGesture() {
                self.navigateTo(page: "petprofile")
            }
                .padding(.top, 30)
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

