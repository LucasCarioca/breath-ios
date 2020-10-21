//
// Created by Lucas Desouza on 5/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import MessageUI
import QuickComponents
import SwiftUI

struct MailButtonView: View {

    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var csvData: Data? = nil

    var body: some View {
        VStack {
            if MFMailComposeViewController.canSendMail() {
                Button("Email records") {
                    self.isShowingMailView.toggle()
                }.frame(width:150, height:50).buttonStyle(PrimaryButton(variant: .empty))
            }
        }.sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: self.$isShowingMailView, result: self.$result, csv: self.$csvData)
        }
    }
}
