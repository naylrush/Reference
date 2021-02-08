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
        self.leftLabel.text = stat.name
        self.rightLabel.text = String(stat.value)
    }

}
