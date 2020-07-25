//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct PetHealthDetailView: View {
    var item: PetHealthItem
    var body: some View {
        VStack {
            HStack {
                Text(item.title).font(.title)
                Spacer()
            }.padding()
            HStack {
                Text(item.content)
                Spacer()
            }.padding()
            item.sourceUrl != nil && item.sourceText != nil ?
                    HStack {
                        Text("Source").fontWeight(.heavy)
                        Button(action: {
                            let url: NSURL = URL(string: self.item.sourceUrl!)! as NSURL
                            UIApplication.shared.open(url as URL)
                        }) {
                            Text(verbatim: self.item.sourceText!)
                        }
                        Spacer()
                    }.padding() : nil
            Spacer()
        }
    }
}