//
//  HowToItemView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 7/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct HowToItemView: View {
    var image: String
    var text: String
    var body: some View {
        HStack{
            Image(image).resizable().frame(width: 50, height: 50)
            Text(text).fontWeight(.heavy)
            Spacer()
        }.padding()
    }
}
