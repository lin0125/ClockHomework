//
//  BSelectDayTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/1.
//

import UIKit

class BSelectDayTableViewCell: UITableViewCell {
    @IBOutlet weak var showDay: UILabel!
    static let identifier = "BSelectDayTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

