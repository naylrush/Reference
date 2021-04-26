//
//  Train.swift
//  Reference
//
//  Created by Alexey Davletshin on 22.04.2021.
//

import Foundation

struct Train {
    var emptyCars: Int
    var loadedCars: Int
    var passengersCars: Int
    
    var mass: Int
    
    var count: Int {
        get {
            return emptyCars + loadedCars + passengersCars
        }
    }
    
    public func isEmpty() -> Bool {
        return emptyCars == 0 && loadedCars == 0 && passengersCars == 0
    }
    
    public func hasOnlyEmptyCars() -> Bool {
        return emptyCars > 0 && loadedCars == 0 && passengersCars == 0
    }
}
