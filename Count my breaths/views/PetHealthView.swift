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
            PetHealthItem(id: 1, title: "Why count breaths", content: "Why count breaths"),
            PetHealthItem(id: 2, title: "Heart disease", content: "Why count breaths")
        ]
        return PetHealth
    }
}

struct PetHealthItem: Identifiable {
    typealias ID = Int
    var id: ID
    var title: String
    var content: String
}