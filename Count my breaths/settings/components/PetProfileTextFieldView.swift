//
//  PetNameView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents
import ToastUI

struct PetProfileTextFieldView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var label: String
    @State var name: String
    @State var confirm = false
    var action: (String) -> Void
    var body: some View {
        VStack {
            Text(label).Heading(size: .H5)
            TextField(label, text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.action(self.name)
                self.confirm = true
            }) {
                Text("Save")
            }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
                    .accessibility(label: Text("Save \(self.label.lowercased())"))
            Spacer()
        }.toast(isPresented: $confirm, dismissAfter: 2.0, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            ToastView("\(self.label) updated").toastViewStyle(SuccessToastViewStyle())
        }
    }
}

