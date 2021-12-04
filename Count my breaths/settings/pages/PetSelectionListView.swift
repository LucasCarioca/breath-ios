//
// Created by Lucas Desouza on 12/3/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetSelectionListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var pets: [Pet] = []
    @State private var refreshID = UUID()
    var body: some View {
        List {
            ForEach(pets.indices, id: \.self) { index in
                HStack {
                    Text(pets[index].name ?? "Missing name")
                    Spacer()
                    Button(action: {selectPet(pets[index])}) {
                        UserDefaults.standard.string(forKey: "CURRENT_PET") == pets[index].name ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "checkmark.circle")
                    }
                }
            }
        }
                .onAppear {
                    pets = petRepository.getAllPets()
                }.id(refreshID)
    }

    func selectPet(_ pet: Pet) {
        UserDefaults.standard.set(pet.name, forKey: "CURRENT_PET")
        refreshID = UUID()
        presentationMode.wrappedValue.dismiss()
    }

}