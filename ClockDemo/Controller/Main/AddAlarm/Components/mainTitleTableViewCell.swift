//
//  mainTitleTableViewCell.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/7/25.
//

import UIKit

class mainTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainTitleSelect: UITextField!
    static let identifier = "mainTitleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func MaintitleSelct(_ sender: Any) {
    }
    
}
