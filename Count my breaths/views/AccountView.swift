//
//  AccountView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Account View")
                        .font(.title)
                        .padding(.bottom)
                    Text("Comming soon...")
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
