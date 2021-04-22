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
        refresh(String(stat.brakePress), String(stat.axesCount), String(stat.pressingPads))
    }
    
    func refreshInTotal(_ center: Int, _ right: Int) {
        refresh("Всего:", String(center), String(right))
    }
    
    func refresh(_ left: String?, _ center: String?, _ right: String?) {
        self.leftLabel.text = left
        self.centerLabel.text = center
        self.rightLabel.text = right
    }
}
