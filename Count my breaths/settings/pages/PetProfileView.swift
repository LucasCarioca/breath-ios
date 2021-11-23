//
//  PetProfile.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct PetProfileView: View {
    @State var petProfile = PetProfileController.loadPetProfile()

    var body: some View {
        VStack {
            List {
                NavigationLink(destination: TargetBreathingRateView(targetBpm: petProfile.targetBpm, action: self.updateTargetBpm)) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Target breathing rate: ")
                        Text("\(petProfile.targetBpm)").fontWeight(.heavy)
                        Spacer()
                    }
                }
                NavigationLink(destination: PetProfileTextFieldView(label: "Pet name", name: petProfile.name, action: self.updateName)) {
                    HStack {
                        Text("Pet name: ")
                        Text("\(petProfile.name)").fontWeight(.heavy)
                        Spacer()
                    }
                }
                NavigationLink(destination: PetProfileTextFieldView(label: "Chip Id", name: petProfile.chipId, action: self.updateChipId)) {
                    HStack {
                        Text("Chip Id: ")
                        Text("\(petProfile.chipId)").fontWeight(.heavy)
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }

    func updateTargetBpm(newTarget: Int) {
        petProfile.targetBpm = newTarget
        PetProfileController.savePetProfile(profile: petProfile)
    }

    func updateName(newName: String) {
        petProfile.name = newName
        PetProfileController.savePetProfile(profile: petProfile)
    }

    func updateChipId(newChipId: String) {
        petProfile.chipId = newChipId
        PetProfileController.savePetProfile(profile: petProfile)
    }
}

struct PetProfile_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
