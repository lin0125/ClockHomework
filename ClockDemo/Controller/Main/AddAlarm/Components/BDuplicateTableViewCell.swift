//
//  BDuplicateTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/25.
//

import UIKit

class BDuplicateTableViewCell: UITableViewCell {
    @IBOutlet weak var duplicateTitle: UILabel!
    @IBOutlet weak var duplicateSelect: UILabel!
    static let identifier = "BDuplicateTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        duplicateTitle.isHidden = true
//        duplicateSelect.isHidden = true
        self.accessoryType = .disclosureIndicator
        // Configure the view for the selected state
    }
    
}
