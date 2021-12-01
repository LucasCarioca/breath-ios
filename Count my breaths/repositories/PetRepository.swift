//
// Created by Lucas Desouza on 11/28/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import Foundation
import CoreData
import SwiftUI

struct PetRepositoryKey: EnvironmentKey {
    static let defaultValue = PetRepository()
}

extension EnvironmentValues {
    var petRepository: PetRepository {
        get {
            self[PetRepositoryKey.self]
        }
        set {
            self[PetRepositoryKey.self] = newValue
        }
    }
}

class PetRepository {
    private var ctx: NSManagedObjectContext?
    private var countRecordRepository: CountRecordRepository?

    init() {}

    init(ctx: NSManagedObjectContext) {
        self.ctx = ctx
        countRecordRepository = CountRecordRepository(ctx: ctx)
    }

    public func setCtx(ctx: NSManagedObjectContext) {
        self.ctx = ctx
        countRecordRepository = CountRecordRepository(ctx: ctx)
    }

    public func delete(_ item: Pet) {
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            ctx.delete(item)
            try ctx.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    //temporary to migrate data from user defaults to core data
    public func createFromDefault() -> Pet {
        print("creating pet from defaults")
        let petProfile = PetProfileController.loadPetProfile()
        let pet = findByName(petProfile.name)
        if let pet = pet {
            print("pet already exists, skipping ...")
            return pet
        }
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            let pet = Pet(context: ctx)
            pet.name = petProfile.name
            pet.chipId = petProfile.chipId
            pet.targetBreathing = Double(petProfile.targetBpm)
            let breathRecords = countRecordRepository?.getAllByPet()
            if let records = breathRecords {
                for record in records {
                    pet.addToBreathRecords(record)
                }
            }
            try ctx.save()
            print("new pet created and records associated")
            return pet
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }


    public func create(
            name: String = "myPet",
            breed: String? = nil,
            birthDate: Date? = nil,
            chipId: String? = nil,
            breathRecords: [CountRecord]? = [],
            targetBreathing: Double = 30)-> Pet {
        let petProfile = PetProfileController.loadPetProfile()
        let pet = findByName(petProfile.name)
        if let pet = pet {
            return pet
        }
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            let pet = Pet(context: ctx)
            pet.name = name
            pet.breed = breed
            pet.birthdate = birthDate
            pet.chipId = chipId
            pet.targetBreathing = targetBreathing
            if let records = breathRecords {
                for record in records {
                    pet.addToBreathRecords(record)
                }
            }
            try ctx.save()
            print("new pet created and records associated")
            return pet
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func findByName(_ name: String) -> Pet? {
        let request = Pet.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            return try ctx.fetch(request).first
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func getAllPets() -> [Pet] {
        let request = Pet.fetchRequest()
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            return try ctx.fetch(request)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func getCurrentPet() -> Pet {
        do {
            let petProfile = PetProfileController.loadPetProfile()
            let pet = findByName(petProfile.name)
            guard let pet = pet else {
                throw NSError()
            }
            return pet
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func save() {
        do {
            guard let ctx = ctx else {
                throw NSError()
            }
            try ctx.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}