//
// Created by Lucas Desouza on 6/28/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack {
            ScrollView {
                Image("toto")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.leading).padding(.trailing).padding(.top)
                Text("Our story").font(.title)
                        .padding()
                Text("A few years ago we found ourselves receiving terrible news. Our dog Toto was diagnosed with mitral valve disease and experienced congestive heart failure. He was given the prognosis of just six to eighteen months. Fortunately we discovered that there was a surgeon in Japan who specialized in mitral valve repair which eventually saved him. He is still with us today 2 years later.")
                        .fontWeight(.heavy)
                        .padding()
                        .multilineTextAlignment(.center)
                Image("icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.leading).padding(.trailing).padding(.top)
                Text("This app").font(.title)
                        .padding()
                Text(" When we found out about his condition we talked to a specialist who got him on the right medication and gave us instructions to track his breathing rate. We got used to counting manually, however that was hard to track and keeping a log for our doctor was cumbersome. As a developer I set out to build something to help.")
                        .fontWeight(.heavy)
                        .padding()
                        .multilineTextAlignment(.center)
            }
        }
    }
}