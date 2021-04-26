//
//  TwoCell.swift
//  Reference
//
//  Created by Alexey Davletshin on 08.02.2021.
//

import UIKit

class TwoCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func refresh(_ left: String?, _ right: String?) {
        self.leftLabel.text = left
        self.rightLabel.text = right
    }
}
