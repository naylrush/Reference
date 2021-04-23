//
//  ReferenceVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ReferenceVC: UITableViewController {
    var threeStatTable = ThreeStatTable()
    var twoStatTable = TwoStatTable()
    
    var locomotiveIsNeeded = false
    
    override func viewWillAppear(_ animated: Bool) {
        alertLocomotiveIsNeeded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ThreeStatTitle + ThreeStatTable + ThreeStatTable.InTotal + Empty + TwoStatTable
        return 1 + threeStatTable.stats.count + 1 + 1 + twoStatTable.stats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        typealias EmptyCell = UITableViewCell
        
        let allThreeStatTableSize = 1 + threeStatTable.stats.count + 1
        
        let row = indexPath.row
        
        switch row {
        case 0: // Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatTitleCell", for: indexPath)
            
            return cell
        case ...threeStatTable.stats.count: // ThreeStats
            let index = row - 1
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
            
            cell.refreshStat(threeStatTable.stats[index])
            
            return cell
        case allThreeStatTableSize - 1: // Sum
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
            
            let total = threeStatTable.inTotal
            cell.refreshInTotal(total.axesCount, total.pressingPads)
            
            return cell
        case allThreeStatTableSize: // Empty
            return EmptyCell()
        case ...(allThreeStatTableSize + twoStatTable.stats.count): // TwoStats
            let index = row - allThreeStatTableSize - 1
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoStatCell", for: indexPath) as! TwoStatCell
            
            cell.refresh(twoStatTable.stats[index])
            
            return cell
        default:
            return EmptyCell()
        }
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
