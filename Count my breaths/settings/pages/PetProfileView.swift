//
//  PetProfile.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct PetProfileView: View {
    @Environment(\.petRepository) var petRepository: PetRepository
    @State private var refreshID = UUID()
    var pet: Pet
    var body: some View {
        List {
            NavigationLink(destination: PetProfileTextFieldView(label: "Target breathing", name: String(format: "%.0f", pet.targetBreathing), action: updateTargetBpm)) {
                HStack {
                    Image(systemName: "timer")
                    Text("Target breathing rate: ")
                    Text("\(String(format: "%.0f", pet.targetBreathing))").fontWeight(.heavy)
                    Spacer()
                }
            }
            NavigationLink(destination: PetProfileTextFieldView(label: "Pet name", name: pet.name ?? "", action: updateName)) {
                HStack {
                    Text("Pet name: ")
                    Text(pet.name ?? "Missing pet name").fontWeight(.heavy)
                    Spacer()
                }
            }
            NavigationLink(destination: PetProfileTextFieldView(label: "Chip Id", name: pet.chipId ?? "", action: updateChipId)) {
                HStack {
                    Text("Chip Id: ")
                    Text(pet.chipId ?? "Missing chip id").fontWeight(.heavy)
                    Spacer()
                }
            }
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                Button(action: selectPet) {
                    HStack {
                        Text("Selected")
                        Spacer()
                        UserDefaults.standard.string(forKey: "CURRENT_PET") == pet.name ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "checkmark.circle")
                    }
                }
            }
        }.id(refreshID).navigationTitle(pet.name ?? "Missing name")
    }

    func updateTargetBpm(newTarget: String) {
        pet.targetBreathing = Double(newTarget) ?? 30
        petRepository.save()
        refreshID = UUID()
    }

    func updateName(newName: String) {
        pet.name = newName
        petRepository.save()
        refreshID = UUID()
    }

    func updateChipId(newChipId: String) {
        pet.chipId = newChipId
        petRepository.save()
    }

    func selectPet() {
        UserDefaults.standard.set(pet.name, forKey: "CURRENT_PET")
        refreshID = UUID()
    }
}