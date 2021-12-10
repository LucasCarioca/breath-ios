//
//  Router.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/20/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct Router: View {
    @State var refreshId = UUID()
    @Binding var selected: Routes?
    @Environment(\.storeManager) var storeManager: StoreManager
    @Environment(\.petRepository) var petRepository: PetRepository
    @State var pet: Pet?

    var body: some View {
        List {
            Section(header: Text("Breathing Tracker")) {
                NavigationLink(
                        destination:
                        CountView()
                                .padding()
                                .navigationBarTitle("Counter"),
                        tag: .counter,
                        selection: self.$selected) {
                    Label("Counter", systemImage: "lungs.fill")
                }
                NavigationLink(
                        destination:
                        HistoryView()
                                .padding()
                                .navigationBarTitle("History"),
                        tag: .history,
                        selection: self.$selected) {
                    Label("History", systemImage: "chart.bar.fill")
                }
            }
            Section(header: Text("Information")) {
                NavigationLink(
                        destination:
                        PetHealthView()
                                .navigationBarTitle("Pet health"),
                        tag: .info,
                        selection: self.$selected) {
                    Label("Pet health", systemImage: "heart.fill")
                }
                NavigationLink(
                        destination:
                        AboutUsView()
                                .navigationBarTitle("About us"),
                        tag: .about,
                        selection: self.$selected) {
                    Label("About us", systemImage: "info.circle.fill")
                }
            }
            Section(header: Text("Settings")) {

                if !UserDefaults.standard.bool(forKey: StoreManager.productKey) {
                    if let pet = pet {
                        NavigationLink(
                                destination: PetProfileView(
                                        pet: pet,
                                        name: pet.name ?? "",
                                        targetBreathing: String(pet.targetBreathing),
                                        chipId: pet.chipId ?? "").onDisappear {
                                    refreshId = UUID()
                                }) {
                            Label(pet.name ?? "No pet name", systemImage: "person.crop.circle.fill")
                        }
                    }
                    NavigationLink(destination: ProFeatures(storeManager: storeManager)) {
                        Label("Unlock All Features", systemImage: "star")
                    }
                } else {
                    NavigationLink(
                            destination:
                            PetListView()
                                    .navigationBarTitle("Pets"),
                            tag: .profile,
                            selection: self.$selected) {
                        Label("Pets", systemImage: "person.crop.circle.fill")
                    }
                    CurrentPetView(onRefresh: { refreshId = UUID() }, label: { name in
                        AnyView(Label("Selected pet: \(name)", systemImage: "checkmark.circle.fill"))
                    })
                }
            }
            #if DEBUG
            Section(header: Text("Hidden Settings")) {
                NavigationLink(destination: DevTools()) {
                    Label("Dev Tools", systemImage: "chevron.left.slash.chevron.right")
                }
            }
            #endif
        }.onAppear {
            let name = UserDefaults.standard.string(forKey: "CURRENT_PET") ?? "MyPet"
            pet = petRepository.findByName(name)
        }
    }
}

enum Routes: Equatable, Identifiable {
    case none
    case counter
    case history
    case pills
    case tracking
    case how
    case info
    case about
    case profile

    var id: Routes {
        self
    }
}
