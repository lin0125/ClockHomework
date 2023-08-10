//
//  BSelectHintTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/3.
//

import UIKit

class BSelectHintTableViewCell: UITableViewCell {
    static let identifier = "BSelectHintTableViewCell"
    @IBOutlet weak var HintTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
