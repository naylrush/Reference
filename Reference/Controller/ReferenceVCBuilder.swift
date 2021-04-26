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
    
    func calcStats(_ train: Train) {
        let threeStats = calcThreeStats(train)
        let threeStatsInTotal = calcInTotal(threeStats)
        
        referenceVC.threeStats = threeStats
        referenceVC.threeStatsInTotal = threeStatsInTotal
        
        let (twoStats, locomotiveIsNeeded) = calcTwoStats(train, threeStatsInTotal.brakingForce)
        
        referenceVC.twoStats = twoStats
        
        referenceVC.locomotiveIsNeeded = locomotiveIsNeeded
    }
    
    private func calcThreeStats(_ train: Train) -> [ThreeStat] {
        var threeStats = [ThreeStat]()
        
        for (brakePress, cars, axesCountByCar) in [(3.5, train.emptyCars, 4),
                                                   (7.0, train.loadedCars, 4),
                                                   (10.0, train.passengersCars, 4)] {
            if cars > 0 {
                threeStats.append(ThreeStat(brakePress: brakePress, axesCount: cars * axesCountByCar))
            }
        }
        return threeStats
    }
    
    private func calcInTotal(_ stats: [ThreeStat]) -> (axesCount: Int, brakingForce: Int) {
        let totalAxesCount = stats.reduce(0) { $0 + $1.axesCount }
        let totalBrakingForce = stats.reduce(0) { $0 + $1.brakingForce }
        
        return (totalAxesCount, totalBrakingForce)
    }
    
    private func calcTwoStats(_ train: Train, _ availableBrakingForce: Int) -> ([TwoStat], Bool) {
        var twoStats = [TwoStat]()
        
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
        
        twoStats.append(TwoStat(name: "Масса поезда:", value: train.mass))
        twoStats.append(TwoStat(name: "Распол. ту:", value: availableBrakingForce))
        twoStats.append(TwoStat(name: "Требуемое ту:", value: requiredBrakingForce))
        
        let locomotiveIsNeeded = requiredBrakingForce > availableBrakingForce
        
        return (twoStats, locomotiveIsNeeded)
    }
    
    private func calcRequiredBrakingForce(_ train: Train, _ coeff: Double) -> Int {
        return Int(ceil(Double(train.mass) * coeff))
    }
}
