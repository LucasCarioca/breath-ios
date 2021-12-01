//
// Created by Lucas Desouza on 11/30/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetListView: View {
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var pets: [Pet] = []
    var body: some View {
        List {
            ForEach(pets) { pet in
                NavigationLink(destination: PetProfileView(pet: pet).navigationTitle(pet.name ?? "Missing name")) {
                    VStack {
                        Text(pet.name ?? "Missing name")
                    }
                }
            }
        }.onAppear {
            pets = petRepository.getAllPets()
        }
    }
}