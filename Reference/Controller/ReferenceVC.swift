//
//  ReferenceVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ReferenceVC: UITableViewController {
    var threeStats: [ThreeStat]!
    var threeStatsInTotal: (axesCount: Int, brakingForce: Int)!
    
    var twoStats: [TwoStat]!
    
    var locomotiveIsNeeded: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        alertLocomotiveIsNeeded()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 { // not ThreeStatTitle
            return 44.0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ThreeStatTitle + ThreeStats + InTotal(ThreeStats) + EmptyCell + TwoStats
        return 1 + threeStats.count + 1 + 1 + twoStats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        typealias EmptyCell = UITableViewCell
        
        let threeStatsRows = 1 + threeStats.count + 1
        
        let row = indexPath.row
        
        switch row {
        case 0: // ThreeStatTitle
            return getThreeStatTitleCell(indexPath)
        case ...threeStats.count: // ThreeStats
            let index = row - 1
            
            let cell = getThreeCell(indexPath)
            refreshThreeStatCell(cell, threeStats[index])
            
            return cell
        case threeStatsRows - 1: // InTotal(ThreeStats)
            let cell = getThreeCell(indexPath)
            
            cell.refresh("Всего:", String(threeStatsInTotal.axesCount), String(threeStatsInTotal.brakingForce))
            
            return cell
        case threeStatsRows: // EmptyCell
            return EmptyCell()
        case ...(threeStatsRows + twoStats.count): // TwoStats
            let index = row - threeStatsRows - 1
            
            let cell = getTwoCell(indexPath)
            refreshTwoStatCell(cell, twoStats[index])
            
            return cell
        default:
            return EmptyCell()
        }
    }
    
    private func getThreeStatTitleCell(_ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ThreeStatTitleCell", for: indexPath)
    }
    
    private func getThreeCell(_ indexPath: IndexPath) -> ThreeCell {
        return tableView.dequeueReusableCell(withIdentifier: "ThreeCell", for: indexPath) as! ThreeCell
    }
    
    private func refreshThreeStatCell(_ cell: ThreeCell, _ stat: ThreeStat) {
        cell.refresh(String(stat.brakePress), String(stat.axesCount), String(stat.brakingForce))
    }
    
    private func getTwoCell(_ indexPath: IndexPath) -> TwoCell {
        return tableView.dequeueReusableCell(withIdentifier: "TwoCell", for: indexPath) as! TwoCell
    }
    
    private func refreshTwoStatCell(_ cell: TwoCell, _ stat: TwoStat) {
        cell.refresh(stat.name, stat.value)
    }
    
    private func getEmptyCell() -> UITableViewCell {
        return UITableViewCell()
    }
    
    private func alertLocomotiveIsNeeded() {
        if (!locomotiveIsNeeded) {
            return
        }
        
        let alert = UIAlertController(
            title: "Необходимо выбрать другой локомотив",
            message: "Поезд тормазами не обеспечен",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Выбрать",
                style: .default,
                handler: {_ in
                    self.dismiss(animated: true)
                }
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Нет",
                style: .destructive,
                handler: nil
            )
        )
        
        self.present(alert, animated: true)
    }
}
