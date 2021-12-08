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
    var pet: Pet
    @State var name: String
    @State var targetBreathing: String
    @State var chipId: String
    @State var selected: Bool = false
    var body: some View {
        Form {
            TextField("Pet Name", text: $name)
                    .padding()
            TextField("Target Breathing Rate", text: $targetBreathing)
                    .padding()
                    .keyboardType(.numberPad)
            TextField("Chip Id", text: $chipId)
                    .padding()
            if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                Button(action: selectPet) {
                    HStack {
                        Text("Selected")
                        Spacer()
                        selected ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "checkmark.circle")
                    }
                }
            }
            Button(action: save) {
                Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
        }
                .onAppear {
                    self.selected = UserDefaults.standard.string(forKey: "CURRENT_PET") == pet.name
                }
                .navigationTitle(pet.name ?? "Missing name")
    }

    func save() {
        pet.name = name
        if selected {
            UserDefaults.standard.set(name, forKey: "CURRENT_PET")
        }
        if let targetBreathing = Double(targetBreathing) {
            pet.targetBreathing = targetBreathing
        }
        pet.chipId = chipId
        petRepository.save()
    }

    func selectPet() {
        UserDefaults.standard.set(pet.name, forKey: "CURRENT_PET")
        selected = true
    }
}