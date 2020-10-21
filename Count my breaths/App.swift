//
//  App.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import ToastUI
import QuickComponents

struct App: View {
    
    @State var showNewVersion = false
    @State var version = VersionController.loadVersion()
    
    var body: some View {
        Navigation()
            .toast(isPresented: $showNewVersion) {
            ToastView {
                VStack {
                    Text("New Features v\(self.version.version) 🎉").Paragraph(align: .center, size: .LG)
                    ScrollView {
                        VStack {
                            Text(self.version.description).Paragraph(align: .center)
                            self.version.newFeatures.count >= 1 ? ForEach(0..<self.version.newFeatures.count) { index in
                                Text(self.version.newFeatures[index]).Paragraph(align: .center)
                            } : nil
                        }
                    }.frame(maxHeight: 150)
                    Button(action: {
                        self.showNewVersion = false
                        self.version.isNew = false
                        VersionController.saveVersion(version: self.version)
                    }) {
                        Text("OK")
                    }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
                }
            }
        }
        .onAppear() {
            if (self.version.isNew) {
                self.showNewVersion = true
            }
        }
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App()
    }
}
