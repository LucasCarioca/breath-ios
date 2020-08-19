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
            Text("Pet profile").Heading(size: .H5)
            List {
                NavigationLink(destination: TargetBreathingRateView(targetBpm: petProfile.targetBpm, action: self.updateTargetBpm)) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Target breathing rate: ")
                        Text("\(petProfile.targetBpm)").fontWeight(.heavy)
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
}

struct PetProfile_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
