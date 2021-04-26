//
//  Train.swift
//  Reference
//
//  Created by Alexey Davletshin on 22.04.2021.
//

import Foundation

struct Train {
    var cars: [(count: Int, car: Car)]
    var hasOnlyEmptyCars: Bool
    
    var mass: Int
    
    var count: Int {
        get {
            return cars.reduce(0) { $0 + $1.count }
        }
    }
    
    public func isEmpty() -> Bool {
        return cars.isEmpty
    }
}
