//
//  BreathingTrackerPages.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/4/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import Foundation
import SwiftUI

enum BreathingTrackerPages: Equatable, Identifiable{
    case counter
    case history
    
    var id: BreathingTrackerPages { self }
}
