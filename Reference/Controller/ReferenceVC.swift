//
//  ReferenceVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ReferenceVC: UITableViewController {
    
    var threeStatTable = ThreeStatTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calcStatTable(loadedCars: Int?, emptyCars: Int?, passengersCars: Int?, trainMass: Int?) {
        for (brakePress, cars, axesCountByCar) in [(3.5, emptyCars, 4),
                                                   (7.0, loadedCars, 4),
                                                   (10.0, passengersCars, 4)] {
            if cars != nil {
                threeStatTable.AddStat(ThreeStat(brakePress: brakePress, axesCount: cars! * axesCountByCar))
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + threeStatTable.stats.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        typealias EmptyCell = UITableViewCell
        
        let row = indexPath.row
        
        switch row {
        case 0: // Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatTitleCell", for: indexPath)
            
            return cell
        case ...threeStatTable.stats.count: // Stats
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
            
            cell.refreshStat(threeStatTable.stats[row - 1])
            
            return cell
        case threeStatTable.stats.count + 1: // Sum
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
        
            cell.refreshInTotal(threeStatTable.inTotal)
            
            return cell
        case threeStatTable.stats.count + 2: // Empty
            return EmptyCell()
        default:
            return EmptyCell()
        }
    }

}
