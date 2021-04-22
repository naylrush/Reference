//
//  TwoStatCell.swift
//  Reference
//
//  Created by Alexey Davletshin on 08.02.2021.
//

import UIKit

class TwoStatCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func refresh(_ stat: TwoStat) {
        refresh(stat.name, String(stat.value))
    }
    
    func refresh(_ left: String?, _ right: String?) {
        self.leftLabel.text = left
        self.rightLabel.text = right
    }
}
