//
//  PetProfile.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct PetProfileView: View {
    var body: some View {
        VStack {
            Text("Pet profile").Heading(size: .H5)
            List {
                NavigationLink(destination: TargetBreathingRateView()) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Target breathing rate")
                        Spacer()
                    }
                }
            }
            Spacer()
        }
    }
}

struct PetProfile_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
