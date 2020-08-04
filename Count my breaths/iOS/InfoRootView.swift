//
//  InfoRootView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//
import Foundation
import SwiftUI
import QuickComponents

struct InfoRootView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewRouter = InfoViewRouter()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.viewRouter.currentView == "health" {
                    PetHealthView().padding(.horizontal)
                } else if self.viewRouter.currentView == "about" {
                    AboutUsView().padding(.horizontal)
                }
                Spacer()
                ZStack {
                    HStack {
                        Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                            .foregroundColor(self.viewRouter.currentView == "about" ? .blue : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        self.viewRouter.currentView = "about"
                                    }
                                }
                        Image(systemName: "info.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width / 3, height: 75)
                            .foregroundColor(self.viewRouter.currentView == "health" ? .blue : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        self.viewRouter.currentView = "health"
                                    }
                                }
                    }
                            .frame(width: geometry.size.width, height: geometry.size.height / 10).padding(.bottom)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct InfoRootView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRootView()
    }
}
