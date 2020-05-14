//
//  CounterService.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 5/12/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import Foundation

public class CounterSerivce {
    private var time: Int = 0
    private var beats: Int = 0
    
    init(time: Int, beats: Int) {
        self.time = time
        self.beats = beats
    }
    
    func calculateBpm() -> Int {
        return (60/time) * beats
    }
 }
