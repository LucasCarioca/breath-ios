//
//  HeaderView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/15/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var subTitle: String?
    
    var body: some View {
        VStack{
            HStack {
            Text(title)
                .font(.title)
            
            Spacer()
            }
            if subTitle != nil{
                HStack {
                    Text(subTitle!)
                    Spacer()
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Some title", subTitle: "Some subtitle")
    }
}
