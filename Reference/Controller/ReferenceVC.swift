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
        for (brakePress, cars, axesCountByCar) in [(3.5, loadedCars, 4),
                                                   (7.0, emptyCars, 4),
                                                   (10.0, passengersCars, 4)] {
            if cars != nil {
                self.statTable.AddStat(Stat(brakePress: brakePress, axesCount: cars! * axesCountByCar))
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }

}
