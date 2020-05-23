//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct BarView: View {

    var value: Int16

    var body: some View {
        VStack {
            ZStack (alignment: .leading) {
                Capsule().frame(width: 300, height: 30).foregroundColor(.gray)
                if value >= 30 {
                    Capsule().frame(width: CGFloat(value * 5), height: 30).foregroundColor(.red)
                } else {
                    Capsule().frame(width: CGFloat(value * 5), height: 30).foregroundColor(.green)
                }
                Text(String(value)).padding()
            }
        }
    }
}