//
//  StatCell.swift
//  Reference
//
//  Created by Alexey Davletshin on 06.02.2021.
//

import UIKit

class StatCell: UITableViewCell {
    
    @IBOutlet weak var brakePressLabel: UILabel!
    @IBOutlet weak var axesCountLabel: UILabel!
    @IBOutlet weak var pressingPadsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
