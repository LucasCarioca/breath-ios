//
//  RootViews.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

enum RootPages: Equatable, Identifiable{
    case breathingTracker
    case info
    
    var id: RootPages { self }
}
