//
//  TargetBreathingRateView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import QuickComponents
import ToastUI

struct TargetBreathingRateView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var targetBpm: Double
    @State var confirm = false
    var action: (Double) -> Void
    var body: some View {
        VStack {
            Text("Target breathing rate").Heading(size: .H5)
            Picker("Target breathing rate", selection: $targetBpm) {
                ForEach(0..<100) {
                    Text("\($0)")
                }
            }.padding().labelsHidden()
            Button(action: {
                action(targetBpm)
                self.confirm = true
            }) {
                Text("Save")
            }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
                    .accessibility(label: Text("Save target breathing rate"))
            Spacer()
        }.toast(isPresented: $confirm, dismissAfter: 2.0, onDismiss: {
            presentationMode.wrappedValue.dismiss()
        }) {
            ToastView("Target breathing rate saved").toastViewStyle(SuccessToastViewStyle())
        }
    }
}
