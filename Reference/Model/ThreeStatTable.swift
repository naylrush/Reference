//
//  StatTable.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import Foundation

class ThreeStatTable {
    public private(set) var stats: [ThreeStat] = []
    
    public var inTotal: (Int, Int) {
        get {
            let totalAxesCount = stats.reduce(0) { $0 + $1.axesCount }
            let totalPressingPads = stats.reduce(0) { $0 + $1.pressingPads }
            
            return (totalAxesCount, totalPressingPads)
        }
    }
    
    func AddStat(_ stat: ThreeStat) {
        stats.append(stat)
    }
}
