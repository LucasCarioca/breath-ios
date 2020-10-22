//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct HowToView: View {
    var body: some View {

        VStack {
            HStack {
                Text("In order to start counting your pets breathing rate follow the steps below.").font(.title)
                Spacer()
            }.padding(.bottom).padding(.top)
            ScrollView {
                VStack {
                    HowToItemView(image: "1.circle.fill", text: "Wait for your pet to go to sleep")
                    HowToItemView(image: "2.circle.fill", text: "Open the app to the counter page")
                    HowToItemView(image: "3.circle.fill", text: "Click on the heart button to start counting")
                    HowToItemView(image: "4.circle.fill", text: "Keep clicking the button for each breath until the timer ends (Be sure to count a full up and down chest movement as a breath)")
                    HowToItemView(image: "5.circle.fill", text: "Once complete, the final count will appear on the screen and in the history page")
                }
            }
        }
    }
}
