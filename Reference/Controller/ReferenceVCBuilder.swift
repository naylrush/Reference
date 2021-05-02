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
    
    private func calcTwoStats(_ train: Train, _ availableBrakingForce: Int) -> (twoStats: [TwoStat], locomotiveIsNeeded: Bool) {
        var twoStats = [TwoStat]()
        
        var requiredBrakingForce = Int()
        var coeff = Double()
        
        if train.hasOnlyEmptyCars {
            coeff = 0.55
            requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
        } else {
            for coeff_100 in stride(from: 33, through: 28, by: -1) {
                coeff = Double(coeff_100) / 100;
                requiredBrakingForce = calcRequiredBrakingForce(train, coeff)
                if (requiredBrakingForce < availableBrakingForce) {
                    break
                }
            }
        }
        
        let (requiredHandbrakeCount, availableHandbrakeCount) = calchandbrakeStats(train)
        
        twoStats.append(("Масса поезда:", "\(train.mass)"))
        twoStats.append(("Требуемое ТУ:", "\(requiredBrakingForce) (\(String(format: "%.2f", coeff)))"))
        twoStats.append(("Распол. ТУ:", "\(availableBrakingForce)"))
        twoStats.append(("Требуемые РТ:", "\(requiredHandbrakeCount)"))
        twoStats.append(("Распол. РТ:", "\(availableHandbrakeCount)"))
        
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
