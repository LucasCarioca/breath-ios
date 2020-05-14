//
//  HistoryView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @FetchRequest(entity: CountRecord.entity(), sortDescriptors: []) var countRecords: FetchedResults<CountRecord>
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("History View")
                        .font(.title)
                        .padding(.bottom)
                    List{
                        ForEach(countRecords, id: \.id) { record in
                            VStack{
                                Text(String(record.beats * 2) + " Breaths per minute").font(.headline)
                                Text(record.timeText ?? "Unknown").font(.subheadline)
                            }
                        }
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
