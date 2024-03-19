//
//  TableViewCell.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 19/3/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var countryRegionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
