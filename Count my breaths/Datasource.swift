//
// Created by Lucas Desouza on 11/23/21.
// Copyright (c) 2021 Lucas Desouza. All rights reserved.
//

import Foundation
import CoreData

class Datasource {
    private static let CONTAINER_NAME = "countmybreaths"
    private let container: NSPersistentCloudKitContainer

    init(inMemory: Bool) {
        if inMemory {
            container = Datasource.inMemory()
        } else {
            container = Datasource.cloud()
        }
    }

    private static func cloud() -> NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: CONTAINER_NAME)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }

    private static func inMemory() -> NSPersistentCloudKitContainer {
        let container = NSPersistentCloudKitContainer(name: CONTAINER_NAME)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }

    public func getContainer() -> NSPersistentCloudKitContainer {
        return container
    }
}
