//
//  ThreeStatCell.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ThreeStatCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func refreshStat(_ stat: ThreeStat) {
        self.leftLabel.text = String(stat.brakePress)
        self.centerLabel.text = String(stat.axesCount)
        self.rightLabel.text = String(stat.pressingPads)
    }
    
    func refreshInTotal(_ inTotal: (Int, Int)) {
        self.leftLabel.text = "Всего:"
        self.centerLabel.text = String(inTotal.0)
        self.rightLabel.text = String(inTotal.1)
    }

}
