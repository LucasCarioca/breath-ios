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
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository
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
            showResults ?
                    CountResults(bpm: bpm) : nil

            isCounting ?
                    AnyView(TimerView(counter: counter, time: timer, max: 30)) : AnyView(CountInstructions())
            Spacer()
            CountButton(action: breath)
                    .onReceive(timePublisher) { time in
                        if (isCounting) {
                            if (timer >= 30) {
                                self.saveRecord(timeInterval: time.timeIntervalSinceReferenceDate)
                                finishCounting()
                            } else {
                                self.timer += 1
                            }
                        }
                    }

            isCounting ? CountResetButton(action: reset) : nil
            Spacer().navigationBarItems(trailing: CountShowHelpButton(action: toggleHelp))
        }.toast(isPresented: $showWarning) {
            CountWarningToast(messageTitle: messageTitle, messageContent: messageContent, action: dismissToast)
        }.onAppear() {
            self.petProfile = PetProfileController.loadPetProfile()
        }.sheet(isPresented: $showHelp) {
            CountHowTowPopOver(action: helpOff)
        }

    }

    func dismissToast() {
        self.showWarning = false
        let keyWindow = UIApplication.shared.windows.first {
            $0.isKeyWindow
        }
        let rootViewController = keyWindow?.rootViewController
        rootViewController?.dismiss(animated: true)
    }

    func toggleHelp() {
        withAnimation {
            self.showHelp.toggle()
        }
    }

    func helpOff() {
        showHelp = false
    }

    func reset() {
        self.isCounting = false
        self.counter = 0
        self.timer = 0
    }

    func finishCounting() {
        self.bpm = counter * 2
        if bpm >= petProfile.targetBpm {
            highBreathing()
        } else {
            normalBreathing()
        }
        reset()
        trackRuns()
    }

    func saveRecord(timeInterval: TimeInterval) {
        countRecordRepository.create(
                elapsedTime: Int16(timer),
                beats: Int16(counter),
                time: Date(timeIntervalSinceReferenceDate: timeInterval))
    }

    func trackRuns() {
        let userDefaults = UserDefaults.standard
        let countRuns = userDefaults.integer(forKey: "countruns")
        userDefaults.set(countRuns + 1, forKey: "countruns")
    }

    func highBreathing() {
        hapticNotification.notificationOccurred(.error)
        self.messageTitle = "Your pets breathing is high"
        self.messageContent = "Your pets breathing rate is \(String(self.bpm)). Please contact your veterinarian."
        self.showResults = true
        self.showWarning = true
    }

    func normalBreathing() {
        hapticNotification.notificationOccurred(.success)
        self.messageTitle = "Your pets breathing is normal"
        self.messageContent = "Your pets breathing rate is \(String(self.bpm))."
        self.showResults = true
    }

    func breath() {
        impactMed.impactOccurred()
        if (!isCounting) {
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
        VStack {
            Text("Breaths: " + String(counter)).font(.title)
                    .font(.subheadline)
            BarView(value: CGFloat(time), max: CGFloat(max), showLabel: false, color: Theme.colors.primary).frame(height: 50)
            Text("Seconds remaining \(max - time)")
        }
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
    }
}
