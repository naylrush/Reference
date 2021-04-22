//
//  ReferenceVCBuilder.swift
//  Reference
//
//  Created by Alexey Davletshin on 22.04.2021.
//

import Foundation


class ReferenceVCBuilder {
    var referenceVC: ReferenceVC
    
    init(_ referenceVC: ReferenceVC) {
        self.referenceVC = referenceVC
    }
    
    func calcStatTables(_ train: Train) {
        let threeStatTable: ThreeStatTable = calcThreeStatTable(train)
        let twoStatTable: TwoStatTable = calcTwoStatTable(train, threeStatTable.inTotal.pressingPads)
        
        referenceVC.threeStatTable = threeStatTable
        referenceVC.twoStatTable = twoStatTable
    }
    
    private func calcThreeStatTable(_ train: Train) -> ThreeStatTable {
        let threeStatTable = ThreeStatTable()
        
        print(train)
        
        for (brakePress, cars, axesCountByCar) in [(3.5, train.emptyCars, 4),
                                                   (7.0, train.loadedCars, 4),
                                                   (10.0, train.passengersCars, 4)] {
            if cars > 0 {
                threeStatTable.AddStat(ThreeStat(brakePress: brakePress, axesCount: cars * axesCountByCar))
            }
        }
        return threeStatTable
    }
    
    private func calcTwoStatTable(_ train: Train, _ availableBrakingForce: Int) -> TwoStatTable {
        let twoStatTable = TwoStatTable()
        
        var requiredBrakingForce: Int
        
        if train.hasOnlyEmptyCars() {
            let coeff = 0.55
            requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
        } else {
            var coeff = 0.33
            requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
            
            while (requiredBrakingForce > availableBrakingForce && coeff >= 0.28) {
                coeff -= 0.01
                requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
            }
        }
        
        if requiredBrakingForce > availableBrakingForce {
            print("Turn on locomotive!")
        }
        
        twoStatTable.AddStat(TwoStat(name: "Масса поезда:", value: train.mass))
        twoStatTable.AddStat(TwoStat(name: "Требуемое ту:", value: requiredBrakingForce))
        
        return twoStatTable
    }
    
    private func calcRequiredBrakingForce(_ train: Train, _ coeff: Double) -> Int {
        return Int(ceil(Double(train.mass) * coeff))
    }
}
