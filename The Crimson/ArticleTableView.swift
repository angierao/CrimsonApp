//
//  ArticleTableView.swift
//  The Crimson
//
//  Created by David Miller on 6/21/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit

class ArticleTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.rowHeight = UITableViewAutomaticDimension
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
