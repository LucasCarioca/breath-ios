//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack{
            HStack{
                Text("In order to start counting your pets breathing rate follow the steps below.")
                Spacer()
            }.padding(.bottom).padding(.top)
            HStack{
                Text("1. Wait for your pet to go to sleep.")
                Spacer()
            }.padding(.bottom)
            HStack{
                Text("2. Open the app to the counter page.")
                Spacer()
            }.padding(.bottom)
            HStack{
                Text("3. Click on the heart button to start counting.")
                Spacer()
            }.padding(.bottom)
            HStack{
                Text("4. Keep clicking the button for each breath until the timer ends. (Be sure to count a full up and down chest movement as a breath)")
                Spacer()
            }.padding(.bottom)
            HStack{
                Text("5. Once complete, the final count will appear on the screen and in the history page.")
                Spacer()
            }
        }
    }
}