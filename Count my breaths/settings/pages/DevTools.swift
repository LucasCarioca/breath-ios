//
// Created by Lucas Desouza on 12/6/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct DevTools: View {
    var body: some View {
        List {
            Button(action: {
                UserDefaults.standard.setValue(true, forKey: StoreManager.productKey)
            }) {
                Text("Enable Pro Features")
            }
            Button(action: {
                UserDefaults.standard.setValue(false, forKey: StoreManager.productKey)
            }) {
                Text("Reset Pro Status")
            }
        }.navigationTitle("Upgrade to Pro")
    }

}

struct DevTools_Previews: PreviewProvider {
    static var previews: some View {
        DevTools()
    }
}