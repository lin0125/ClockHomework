//
//  AddTimeIteamTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/25.
//

import UIKit

class AddTimeIteamTableViewCell: UITableViewCell {
    @IBOutlet weak var APMTimeLabel: UILabel!
    @IBOutlet weak var SetTimeLabel: UILabel!
    @IBOutlet weak var SetTitleLabel: UILabel!
    @IBOutlet weak var setSelectDay: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    static let identifier = "AddTimeIteamTableViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
