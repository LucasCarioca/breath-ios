//
// Created by Lucas Desouza on 6/14/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI
import QuickComponents
import SwiftUICharts
import CoreData

enum QueryBy: Int {
    case MAX = 0
    case WEEK = 7
    case TWO_WEEKS = 14
    case MONTH = 30
    case SIX_MONTHS = 180
}

struct GraphView: View {
    @Environment(\.countRecordRepository) var countRecordRepository: CountRecordRepository
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var pet: Pet? = nil
    @State var countRecords: [CountRecord] = []
    var filter: QueryBy

    init() {
        filter = .MAX
    }

    init(by: QueryBy) {
        filter = by
    }

    var body: some View {
        VStack {
            if countRecords.count > 1 {
                LineView(data: getBpmList())
            } else {
                Text("Before we can chart some graphs we need at least two measurements. Come back after you have taken some.").Paragraph(align: .center, size: .MD)
                LottieView(filename: "empty")
                if UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    ManualRecordButton()
                    Spacer()
                }
            }
        }.onAppear {
            let name = UserDefaults.standard.string(forKey: "CURRENT_PET") ?? "MyPet"
            pet = petRepository.findByName(name)
            self.countRecords = fetch()
        }

    }

    func fetch() -> [CountRecord] {
        let range = getRange(filter)
        return countRecordRepository.getAllCountRecordsByPet(from: range.from, to: range.to, pet: pet).reversed()
    }

    func getBpmList() -> [Double] {
        var list: [Double] = []
        for record in countRecords {
            list.append(Double(record.beats * 2))
        }
        return list.reversed()
    }

}

