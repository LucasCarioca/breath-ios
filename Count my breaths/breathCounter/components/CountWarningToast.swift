//
// Created by Lucas Desouza on 11/27/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import ToastUI
import QuickComponents

struct CountWarningToast: View{
    var messageTitle: String
    var messageContent: String
    var action: () -> Void
    var body: some View {
        ToastView {
            VStack {
                Text(messageTitle).Heading(align: .center, size: .H6)
                HStack {
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill").imageScale(.large).foregroundColor(.yellow)
                    Spacer()
                }
                Text(messageContent).Paragraph(align: .center, size: .MD)
                Button(action: action) {
                    Text("OK")
                }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
            }
        }
    }
}
