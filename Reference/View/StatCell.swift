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
    
    func refreshStat(_ stat: Stat) {
        self.brakePressLabel.text = String(stat.brakePress)
        self.axesCountLabel.text = String(stat.axesCount)
        self.pressingPadsLabel.text = String(stat.pressingPads)
    }
    
    func refreshInTotal(_ inTotal: (Int, Int)) {
        self.brakePressLabel.text = "Всего:"
        self.axesCountLabel.text = String(inTotal.0)
        self.pressingPadsLabel.text = String(inTotal.1)
    }

}
