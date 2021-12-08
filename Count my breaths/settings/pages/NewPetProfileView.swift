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
    @State var targetBreathing = ""
    @State var chipId: String = ""

    var body: some View {
        VStack {
            Form {
                TextField("Pet Name", text: $name)
                        .padding()
                TextField("Target Breathing Rate", text: $targetBreathing)
                        .padding()
                        .keyboardType(.numberPad)
                TextField("Chip Id", text: $chipId)
                        .padding()
                Button(action: save) {
                    Text("Save")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
            }
                    .id(refreshID)
                    .navigationTitle("New Pet")
        }
    }

    func save() {
        if name.count >= 1 {
            let _ = petRepository.create(name: name, chipId: chipId, targetBreathing: Double(targetBreathing) ?? 30)
            refreshID = UUID()
            presentationMode.wrappedValue.dismiss()
        }
    }
}