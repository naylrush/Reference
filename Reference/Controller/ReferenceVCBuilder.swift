//
//  ReferenceVCBuilder.swift
//  Reference
//
//  Created by Alexey Davletshin on 22.04.2021.
//

import Foundation


class ReferenceVCBuilder {
    let referenceVC: ReferenceVC
    
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
        
        train.cars
            .sorted() { $0.car.brakePress < $1.car.brakePress }
            .forEach() {
                threeStats.append(
                    ThreeStat(brakePress: $0.car.brakePress, axesCount: $0.count * $0.car.axesCount)
                )
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
        
        var requiredBrakingForce: Int!
        
        if train.hasOnlyEmptyCars {
            let coeff = 0.55
            requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
        } else {
            for coeff in stride(from: 0.28, to: 0.33, by: 0.01).reversed() {
                requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
                if (requiredBrakingForce > availableBrakingForce) {
                    break
                }
            }
        }
        
        let (requiredHandbrakeCount, availableHandbrakeCount) = calchandbrakeStats(train)
        
        twoStats.append(TwoStat(name: "Масса поезда:", value: train.mass))
        twoStats.append(TwoStat(name: "Требуемое ТУ:", value: requiredBrakingForce))
        twoStats.append(TwoStat(name: "Распол. ТУ:", value: availableBrakingForce))
        twoStats.append(TwoStat(name: "Требуемые РТ:", value: requiredHandbrakeCount))
        twoStats.append(TwoStat(name: "Распол. РТ:", value: availableHandbrakeCount))
        
        let locomotiveIsNeeded = requiredBrakingForce > availableBrakingForce
        
        return (twoStats, locomotiveIsNeeded)
    }
    
    private func calcRequiredBrakingForce(_ train: Train, _ coeff: Double) -> Int {
        return Int(ceil(Double(train.mass) * coeff))
    }
    
    private func calchandbrakeStats(_ train: Train) -> (requiredHandbrakeCount: Int, availableHandbrakeCount: Int) {
        let handbrakeCount = Int(ceil(Double(train.mass) * 0.006))
        let half = (train.count + 1) / 2
        let availableHandbrakeCount = (half + (half % 2)) * 4
        
        return (handbrakeCount, availableHandbrakeCount)
    }
}
