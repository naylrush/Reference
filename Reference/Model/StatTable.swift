//
//  StatTable.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import Foundation

class StatTable {
    public private(set) var stats: [Stat] = []
    
    init(stats: [Stat]) {
        self.stats = stats
    }
}
