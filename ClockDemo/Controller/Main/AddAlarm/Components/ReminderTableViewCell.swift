//
//  ReminderTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/25.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var RemindeTitle: UILabel!
    @IBOutlet weak var RemideSelect: UISwitch!
    static let identifier = "ReminderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
