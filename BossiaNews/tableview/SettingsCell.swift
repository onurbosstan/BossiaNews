//
//  ProfileCell.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 12.01.2024.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var iconBg: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconBg.layer.cornerRadius = 10
        iconBg.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
