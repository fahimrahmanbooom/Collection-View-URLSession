//
//  detailTableViewCell.swift
//  Collection View AF
//
//  Created by Fahim Rahman on 3/2/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailCellLabel: UILabel!
    
    @IBOutlet weak var detailCellData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
