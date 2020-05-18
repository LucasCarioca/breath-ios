//
//  CountView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import CoreData

struct CountView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: CountRecord.entity(), sortDescriptors: []) var countRecords: FetchedResults<CountRecord>
    
    @State var timePublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var counter = 0
    @State var isCounting = false
    @State var timer = 0
    @State var showResults = false
    @State var bpm: Int = 0
    
    var body: some View {
        VStack {
            HeaderView(title: "Counter", subTitle: nil)
            Spacer()
            Text("Breaths: " + String(self.counter))
                .font(.subheadline)
            Text("Seconds " + String(self.timer))
                .font(.subheadline)
                .onReceive(self.timePublisher) { time in
                    if(self.isCounting) {
                        if (self.timer >= 30) {
                            self.isCounting = false
                            self.showResults = true
                            self.bpm = self.counter * 2
                            let record = CountRecord(context: self.managedObjectContext)
                            record.elapsedTime = Int16(self.timer)
                            record.beats = Int16(self.counter)
                            record.time = Date(timeIntervalSinceReferenceDate: time.timeIntervalSinceReferenceDate)
                            let df = DateFormatter()
                            df.dateFormat = "MM-dd-yyyy hh:mm:ss"
                            record.timeText = df.string(from: record.time ?? Date())
                            try? self.managedObjectContext.save()
                            self.timer = 0
                        } else {
                            self.timer += 1
                        }
                    }
            }
            if self.showResults {
                Text("Counted " + String(self.bpm) + " beats per minute.")
            }
            Spacer()
            Spacer()
            Button(action: {
                if (!self.isCounting) {
                    self.timePublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    self.counter = 1
                    self.isCounting = true
                    self.timer = 0
                } else {
                    self.counter += 1
                }
            }) {
                GeometryReader { geometry in
                    
                    Image("icon-sm").frame(width: geometry.size.width, height: geometry.size.height).background(Color(red:78/255, green:78/255, blue:78/255)).cornerRadius(20)
                }
            }.buttonStyle(PlainButtonStyle())
            Spacer()
            Spacer()
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
    }
}
