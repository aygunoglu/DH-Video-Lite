//
//  TitleCell.swift
//  DH Video Lite
//
//  Created by Hasan Aygünoglu on 30.08.2021.
//

import UIKit

class TitleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theme_backgroundColor = GlobalPicker.backgroundColor
        titleLabel.theme_textColor = GlobalPicker.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
