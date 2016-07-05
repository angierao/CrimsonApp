//
//  ArticleListCell.swift
//  The Crimson
//
//  Created by David Miller on 3/2/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {
    
    // Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}