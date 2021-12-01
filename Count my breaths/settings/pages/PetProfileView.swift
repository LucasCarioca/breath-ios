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
    @State var pet: Pet
    var body: some View {
        List {
            NavigationLink(destination: TargetBreathingRateView(targetBpm: petProfile.targetBpm, action: updateTargetBpm)) {
                HStack {
                    Image(systemName: "timer")
                    Text("Target breathing rate: ")
                    Text("\(String(format: "%.0f", pet.targetBreathing ?? 30))").fontWeight(.heavy)
                    Spacer()
                }
            }
            NavigationLink(destination: PetProfileTextFieldView(label: "Pet name", name: petProfile.name, action: updateName)) {
                HStack {
                    Text("Pet name: ")
                    Text(pet.name ?? "Missing pet name").fontWeight(.heavy)
                    Spacer()
                }
            }
            NavigationLink(destination: PetProfileTextFieldView(label: "Chip Id", name: petProfile.chipId, action: updateChipId)) {
                HStack {
                    Text("Chip Id: ")
                    Text(pet.chipId ?? "Missing chip id").fontWeight(.heavy)
                    Spacer()
                }
            }
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