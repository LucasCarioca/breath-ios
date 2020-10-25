//
//  CountView.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI
import CoreData
import QuickComponents
import ToastUI

struct CountView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: requestBuilder(limit: 1, sort: [])) var countRecords: FetchedResults<CountRecord>

    @State var showHelp: Bool = false
    @State var timePublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isCounting = false
    @State var counter = 0
    @State var timer = 0
    @State var bpm: Int = 0
    
    @State var showResults = false
    @State var showWarning = false
    @State var messageTitle: String = ""
    @State var messageContent: String = ""
    
    @State var petProfile = PetProfileController.loadPetProfile()
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    let hapticNotification = UINotificationFeedbackGenerator()
    

    var body: some View {
        VStack {            
            self.showResults ?
                Text("Counted " + String(self.bpm) + " beats per minute.")
                    .Paragraph(align: .center, size: .MD) : nil
            
            if(self.isCounting) {
                TimerView(counter: self.counter, time: self.timer, max: 30)
            } else {
                Text("Click on the heart below to start counting").Paragraph(align: .center, size: .MD)
            }
            Spacer()
            
            Button(action: self.breath) {
                GeometryReader { geometry in
                    Image("icon")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color(red:78/255, green:78/255, blue:78/255))
                        .cornerRadius(20)
                }
            }.accessibility(label: Text("Start counting")).buttonStyle(PlainButtonStyle())
            .onReceive(self.timePublisher) { time in
                if(self.isCounting) {
                    if (self.timer >= 30) {
                        self.saveRecord(timeInterval: time.timeIntervalSinceReferenceDate)
                        self.finishCounting()
                    } else {
                        self.timer += 1
                    }
                }
            }

            self.isCounting ? Button(action: self.reset){
                    Text("Reset")
            }.frame(height:50).buttonStyle(SecondaryButton()) : nil
            Spacer()
                .navigationBarItems(trailing: (
                    Button(action: {
                        withAnimation {
                            self.showHelp.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 2).foregroundColor(.clear).frame(width: 40, height: 40)
                            Image(systemName: "info.circle.fill").imageScale(.large)
                        }
                    }
                ))
        }.toast(isPresented: $showWarning) {
            ToastView{
                VStack {
                    Text(self.messageTitle).Heading(align: .center,size: .H6)
                    HStack{
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill").imageScale(.large).foregroundColor(.yellow)
                        Spacer()
                    }
                    Text(self.messageContent).Paragraph(align: .center, size: .MD)
                    Button(action: {
                        self.showWarning = false
                        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
                        let rootViewController = keyWindow?.rootViewController
                        rootViewController?.dismiss(animated: true)
                    }) {
                        Text("OK")
                    }.buttonStyle(PrimaryButton(variant: .contained)).frame(width: 100, height: 50)
                }
            }
        }.onAppear() {
            self.petProfile = PetProfileController.loadPetProfile()
        }.sheet(isPresented: $showHelp) {
            VStack {
                HowToView()
                Button(action: {
                    self.showHelp = false
                }) {
                    Text("Close")
                }.buttonStyle(SecondaryButton()).frame(width: 100, height: 50)
            }.padding()
        }
        
    }
    
    func reset() {
        self.isCounting = false
        self.counter = 0
        self.timer = 0
    }
    
    func finishCounting() {
        print("finished counting")
        self.bpm = self.counter * 2
        if self.bpm >= petProfile.targetBpm {
            highBreathing()
        } else {
            normalBreathing()
        }
        reset()
        trackRuns()
    }
    
    func saveRecord(timeInterval: TimeInterval) {
        let record = CountRecord(context: self.managedObjectContext)
        record.elapsedTime = Int16(self.timer)
        record.beats = Int16(self.counter)
        record.time = Date(timeIntervalSinceReferenceDate: timeInterval)
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy hh:mm:ss"
        record.timeText = df.string(from: record.time ?? Date())
        do{
           try self.managedObjectContext.save()
        } catch {
            print("Failed to save")
        }
    }
    
    func trackRuns() {
        let userDefaults = UserDefaults.standard
        let countRuns = userDefaults.integer(forKey: "countruns")
        userDefaults.set(countRuns+1, forKey: "countruns")
    }
    
    func highBreathing() {
        self.hapticNotification.notificationOccurred(.error)
        self.messageTitle = "Your pets breathing is high"
        self.messageContent = "Your pets breathing rate is \(String(self.bpm)). Please contact your veterinarian."
        self.showResults = true
        self.showWarning = true
    }
    
    func normalBreathing() {
        self.hapticNotification.notificationOccurred(.success)
        self.messageTitle = "Your pets breathing is normal"
        self.messageContent = "Your pets breathing rate is \(String(self.bpm))."
        self.showResults = true
    }
    
    func breath() {
        print("breath counted")
        self.impactMed.impactOccurred()
        if (!self.isCounting) {
            self.showResults = false
            self.timePublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            self.counter = 1
            self.isCounting = true
            self.timer = 0
        } else {
            self.counter += 1
        }
    }
}

struct TimerView: View {
    
    var counter: Int
    var time: Int
    var max: Int
    
    var body: some View {
        VStack{
            Text("Breaths: " + String(counter)).font(.title)
            .font(.subheadline)
            BarView(value: CGFloat(time), max: CGFloat(max), showLabel: false, color: Theme.colors.primary).frame(height:50)
            Text("Seconds remaining \(max-time)")
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
    }
}
