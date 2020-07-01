//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetHealthDetailView: View {
    var item: PetHealthItem
    var body: some View {
        VStack{
            HStack{
                Text(item.title).font(.title)
                Spacer()
            }.padding()
            HStack{
                Text(item.content)
                Spacer()
            }.padding()
            Spacer()
        }
    }
}