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
    @State var petProfile = PetProfileController.loadPetProfile()
    @State var targetBPM = 30
    @State var confirm = false
    init() {
        self.targetBPM = petProfile.targetBpm
    }
    var body: some View {
        VStack {
            Text("Target breathing rate").Heading(size: .H5)
            
            Picker("Target breathing rate", selection: $targetBPM) {
                ForEach(2 ..< 100) {
                    Text("\($0) breaths per minute")
                }
                }.padding().labelsHidden()
            Spacer()
            Button(action: self.updateBreathingRate) {
                Text("Save")
            }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
        }.toast(isPresented: $confirm, dismissAfter: 2.0, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            ToastView("Target breathing rate saved").toastViewStyle(SuccessToastViewStyle())
        }
    }
    
    func updateBreathingRate() {
        petProfile.targetBpm = targetBPM
        PetProfileController.savePetProfile(profile: petProfile)
        confirm = true
    }
}

struct TargetBreathingRateView_Previews: PreviewProvider {
    static var previews: some View {
        TargetBreathingRateView()
    }
}
