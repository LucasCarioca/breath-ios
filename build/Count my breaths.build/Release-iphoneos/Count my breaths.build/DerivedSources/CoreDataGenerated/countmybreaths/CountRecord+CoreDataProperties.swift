//
//  CountRecord+CoreDataProperties.swift
//  
//
//  Created by Lucas Desouza on 5/13/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CountRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountRecord> {
        return NSFetchRequest<CountRecord>(entityName: "CountRecord")
    }

    @NSManaged public var beats: Int16
    @NSManaged public var elapsedTime: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var timeText: String?

}
