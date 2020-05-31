//
// Created by Lucas Desouza on 5/30/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import CoreData

func requestBuilder(limit: Int, sort: [NSSortDescriptor]) -> NSFetchRequest<CountRecord> {
    let request: NSFetchRequest<CountRecord> = CountRecord.fetchRequest()
    request.fetchLimit = limit
    request.sortDescriptors = sort
    return request
}