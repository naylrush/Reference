//
//  ThreeStat.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import Foundation

struct ThreeStat {
    let brakePress: Double
    let axesCount: Int
    let brakingForce: Int
    
    init(brakePress: Double, axesCount: Int) {
        self.brakePress = brakePress
        self.axesCount = axesCount
        self.brakingForce = Int(ceil(brakePress * Double(axesCount)))
    }
}
