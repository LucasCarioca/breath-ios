//
// Created by Lucas Desouza on 11/30/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetListView: View {
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var pets: [Pet] = []
    @State private var refreshID = UUID()
    var body: some View {
        List {
            ForEach(pets.indices, id: \.self) { index in
                NavigationLink(destination: PetProfileView(pet: pets[index]).navigationTitle(pets[index].name ?? "Missing name")) {
                    VStack {
                        Text(pets[index].name ?? "Missing name")
                    }
                }
            }
        }
                .onAppear {
                    pets = petRepository.getAllPets()
                }.id(refreshID)
                .toolbar {
                    NavigationLink(destination: NewPetProfileView()) {
                        Image(systemName: "plus")
                    }
                }
    }
}