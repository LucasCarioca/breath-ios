//
//  PetProfile.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct NewPetProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.petRepository) var petRepository: PetRepository
    @State private var refreshID = UUID()
    @State var name: String = ""
    @State var targetBreathing: Double = 30
    @State var chipId: String = ""

    var body: some View {
        VStack {
            List {
                NavigationLink(destination: PetProfileTextFieldView(label: "Target breathing", name: String(format: "%.0f", targetBreathing), action: updateTargetBpm)) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Target breathing rate: ")
                        Text("\(String(format: "%.0f", targetBreathing))").fontWeight(.heavy)
                        Spacer()
                    }
                }
                NavigationLink(destination: PetProfileTextFieldView(label: "Pet name", name: name, action: updateName)) {
                    HStack {
                        Text("Pet name: ")
                        Text(name).fontWeight(.heavy)
                        Spacer()
                    }
                }
                NavigationLink(destination: PetProfileTextFieldView(label: "Chip Id", name: chipId, action: updateChipId)) {
                    HStack {
                        Text("Chip Id: ")
                        Text(chipId).fontWeight(.heavy)
                        Spacer()
                    }
                }
            }.id(refreshID)
            Spacer()
            Button(action: save) {
                Text("Save")
            }
        }
    }

    func updateTargetBpm(newTarget: String) {
        targetBreathing = Double(newTarget) ?? 30
    }

    func updateName(newName: String) {
        name = newName
    }

    func updateChipId(newChipId: String) {
        chipId = newChipId
    }

    func save() {
        let _ = petRepository.create(name: name, chipId: chipId, targetBreathing: targetBreathing)
        refreshID = UUID()
        presentationMode.wrappedValue.dismiss()
    }
}