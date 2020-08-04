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

    var body: some View {
        VStack {
            SwitcherView(pages: [
                SwitcherPage(label: "Using this app", view: HowToView()),
                SwitcherPage(label: "Pet Health", view: PetHealthView()),
                SwitcherPage(label: "AboutUs", view: AboutUsView())
            ])
            Spacer()
        }
        .navigationBarTitle(Text("Information"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "line.horizontal.3").imageScale(.large)
                }
            }.buttonStyle(PlainButtonStyle())
        )
    }
}

struct InfoRootView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRootView()
    }
}
