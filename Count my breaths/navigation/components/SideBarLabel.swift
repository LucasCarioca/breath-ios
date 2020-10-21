//
//  SideBarLabel.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/17/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct SideBarLabel: View {
    var text: String
    var systemImage: String
    
    init(_ text: String, systemImage: String) {
        self.text = text
        self.systemImage = systemImage
    }
    
    var body: some View {
        HStack {
            Image(systemName: systemImage).resizable().frame(width: 25, height: 25)
            Text(text).Paragraph(size: .MD)
        }
    }
}
