//
//  Article.swift
//  The Crimson
//
//  Created by David Miller on 3/1/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit

class Article {
    
    var title: String
    var subtitle: String
    var link: String
    
    init?(title: String, subtitle: String, link:String) {
        self.title = title
        self.subtitle = subtitle
        self.link = link
        
        // Initialization should fail if there is no title or link
        if title.isEmpty || link.isEmpty {
            return nil
        }
    }
    
}