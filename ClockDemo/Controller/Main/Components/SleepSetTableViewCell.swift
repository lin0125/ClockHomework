//
//  SleepSetTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/10.
//

import UIKit

class SleepSetTableViewCell: UITableViewCell {
    @IBOutlet weak var TitleSleepSet: UILabel!
    @IBOutlet weak var SetSleep: UIButton!
    static let identifier = "SleepSetTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
