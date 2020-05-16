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
    @FetchRequest(entity: CountRecord.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CountRecord.time, ascending: false)]) var countRecords: FetchedResults<CountRecord>
    
    var body: some View {
        VStack {
            HeaderView(title: "History", subTitle: "Previous records will show up here.")
            List{
                ForEach(countRecords.indices) { record in
                    RecordView(beats: self.countRecords[record].beats, timeText: self.countRecords[record].timeText ?? "unknown")
                }
            }
        }
    }
}

struct BarView: View {
    
    var value: Int16
    
    var body: some View {
        VStack {
            ZStack (alignment: .leading) {
                Capsule().frame(width: 300, height: 30).foregroundColor(.gray)
                if value >= 30 {
                        Capsule().frame(width: CGFloat(value * 5), height: 30).foregroundColor(.red)
                } else {
                        Capsule().frame(width: CGFloat(value * 5), height: 30).foregroundColor(.green)
                }
                Text(String(value)).padding()
            }
        }
    }
}

struct RecordView: View {
    var beats: Int16
    var timeText: String
    
    var body: some View {
        VStack{
            HStack {
                BarView(value: beats * 2)
                Spacer()
            }
            HStack {
                Text(timeText).font(.subheadline)
                Spacer()
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}


