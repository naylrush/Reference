//
//  ReferenceVC.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ReferenceVC: UITableViewController {
    
    var statTable = StatTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calcStatTable(loadedCars: Int?, emptyCars: Int?, passengersCars: Int?) {
        for (brakePress, cars, axesCountByCar) in [(3.5, emptyCars, 4),
                                                   (7.0, loadedCars, 4),
                                                   (10.0, passengersCars, 4)] {
            if cars != nil {
                self.statTable.AddStat(Stat(brakePress: brakePress, axesCount: cars! * axesCountByCar))
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.statTable.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case 0: // Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatTitleCell", for: indexPath)
            
            return cell
        case 1..<self.statTable.count: // Stats
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
            
            cell.refreshStat(self.statTable.stats[row - 1])
            
            return cell
        case self.statTable.count: // Sum
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeStatCell", for: indexPath) as! ThreeStatCell
        
            cell.refreshInTotal(self.statTable.inTotal)
            
            return cell
        default:
            return UITableViewCell()
        }
    }

}
