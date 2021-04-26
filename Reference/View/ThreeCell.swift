//
//  ThreeCell.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class ThreeCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func refresh(_ left: String?, _ center: String?, _ right: String?) {
        self.leftLabel.text = left
        self.centerLabel.text = center
        self.rightLabel.text = right
    }
}
