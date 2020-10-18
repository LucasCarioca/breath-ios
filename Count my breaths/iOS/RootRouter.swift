//
//  SwiftUIView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct RootRouter: View {
    var currentView: String
    var width: CGFloat
    var height: CGFloat
    var showMenu: Bool
    var body: some View {
        VStack{
            if currentView == "info" {
                InfoRootView()
                        .frame(width: width, height: height)
                        .offset(x: showMenu ? width / 2 : 0)
                        .disabled(showMenu ? true : false).navigationBarTitle("Information", displayMode: .inline)
            } else if currentView == "petprofile" {
                PetProfileView()
                        .frame(width: width, height: height)
                        .offset(x: showMenu ? width / 2 : 0)
                        .disabled(showMenu ? true : false).navigationBarTitle("Information", displayMode: .inline)
            } else {
                BreathingTrackerRootView()
                        .frame(width: width, height: height)
                        .offset(x: showMenu ? width / 2 : 0)
                        .disabled(showMenu ? true : false).navigationBarTitle("Breathing Tracker", displayMode: .inline)
            }
        }
    }
    
    func getView() {
        
    }
}
