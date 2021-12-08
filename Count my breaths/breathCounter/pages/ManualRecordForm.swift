//
// Created by Lucas Desouza on 12/8/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct ManualRecordForm: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var bpm: String = ""
    @State var date = Date()
    @State var pet: Pet?
    var body: some View {
        VStack {
            Form {
                TextField("Breaths per minute", text: $bpm)
                        .padding()
                        .keyboardType(.numberPad)
                DatePicker("Start date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                Button("Save", action: createRecord)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
        }
                .navigationTitle("New manual record")
                .onAppear {
                    let name = UserDefaults.standard.string(forKey: "CURRENT_PET") ?? "MyPet"
                    pet = petRepository.findByName(name)
                }
    }

    func createRecord() {
        let bpm = Int16(bpm)
        if let bpm = bpm, let pet = pet {
            let _ = countRecordRepository.create(elapsedTime: 30, beats: bpm/2, time: date, pet: pet)
            presentationMode.wrappedValue.dismiss()
        }
    }
}
