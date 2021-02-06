//
//  StatTable.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import Foundation

class StatTable {
    public private(set) var stats: [Stat] = []
    
    public private(set) var inTotal: (Int, Int)
    
    init(stats: [Stat]) {
        self.stats = stats
        
        let totalAxesCount = stats.reduce(0) { $0 + $1.axesCount }
        let totalPressingPads = stats.reduce(0) { $0 + $1.pressingPads }
        
        self.inTotal = (totalAxesCount, totalPressingPads)
    }
}
