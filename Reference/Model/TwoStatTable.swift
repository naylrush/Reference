//
//  TwoStatTable.swift
//  Reference
//
//  Created by Alexey Davletshin on 08.02.2021.
//

import Foundation

class TwoStatTable {
    public private(set) var stats: [TwoStat] = []
    
    func AddStat(_ stat: TwoStat) {
        stats.append(stat)
    }
}
