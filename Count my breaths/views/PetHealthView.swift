//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetHealthView: View {
    var body: some View {
        List {
            ForEach(getList()) { item in
                NavigationLink(destination: PetHealthDetailView(item: item)) {
                    Text(item.title)
                }
            }
        }
    }

    func getList() -> [PetHealthItem] {
        let PetHealth: [PetHealthItem] = [
            PetHealthItem(
                    id: 1,
                    title: "Why count breaths", 
                    content: "Fast breathing when resting or sleeping (more than 30 breaths per minute) is a sign of heart disease or heart failure. Home breathing rate should be evaluated at least once per day in all pets that have heart disease or heart failure and are now taking medications such as furosemide and pimobendan.",
                    sourceUrl: "https://vcahospitals.com/know-your-pet/home-breathing-rate-evaluation",
                    sourceText: "VCA Hospitals"
            ),
            PetHealthItem(
                    id: 2,
                    title: "Dog Heart disease", 
                    content: "Heart disease in dogs is nearly as common as with humans. Even though diet and exercise do play a role, most cases cannot be avoided. The exception is with heartworm disease which is responsible for about 13% of all dogs with heart disease. It is recommended to take your dogs to your veterinarian for routine checkups at least once a year and every 6 months for older dogs.",
                    sourceUrl: "http://www.pethealthnetwork.com/dog-health/dog-diseases-conditions-a-z/dogs-and-heart-disease-overview",
                    sourceText: "Pet Health Network")
        ]
        return PetHealth
    }
}

struct PetHealthItem: Identifiable {
    typealias ID = Int
    var id: ID
    var title: String
    var content: String
    var sourceUrl: String?
    var sourceText: String?
}