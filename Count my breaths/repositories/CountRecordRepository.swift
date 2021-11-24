//
// Created by Lucas Desouza on 11/23/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

struct CountRecordRepositoryKey: EnvironmentKey {
    static let defaultValue = CountRecordRepository()
}

extension EnvironmentValues {
    var countRecordRepository: CountRecordRepository {
        get { self[CountRecordRepositoryKey.self] }
        set { self[CountRecordRepositoryKey.self] = newValue }
    }
}

class CountRecordRepository {
    private var ctx: NSManagedObjectContext?

    init() {}

    init(ctx: NSManagedObjectContext) {
        self.ctx = ctx
    }

    public func setCtx(ctx: NSManagedObjectContext) {
        self.ctx = ctx
    }


    public func getAllBreathRecords() -> [CountRecord] {
        let request = CountRecord.fetchRequest()
        do {
            guard let ctx = ctx else { throw NSError()}
            return try ctx.fetch(request)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func queryBreathRecords(_ query: NSFetchRequest<CountRecord>) -> [CountRecord] {
        let request = CountRecord.fetchRequest()
        do {
            guard let ctx = ctx else { throw NSError()}
            return try ctx.fetch(request)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
