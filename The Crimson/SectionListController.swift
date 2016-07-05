//
//  SectionListController.swift
//  The Crimson
//
//  Created by David Miller on 3/6/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit
import CoreData

class SectionListController: UITableViewController {

    // Create arrays to store the sections
    var sections = [String]()
    
    // Make places to store bookmarks and recently viewed
    var savedArticles = [NSManagedObject]()
    var recentlyViewed = [NSManagedObject]()
    
    // Create link to store feed link
    var link = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make the status bar white font
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Some sections don't have RSS feeds yet - these are the ones that work
        sections = ["**********Top Stories", "Saved for Later", "News", "Opinion", "**********Features", "**********Magazine", "Sports", "Arts", "**********Multimedia", "**********Flyby", "Recently Viewed"]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell", forIndexPath: indexPath) as! SectionListCell
        
        // Fetch the right section and its link
        print(indexPath.row)
        cell.sectionLabel!.text = sections[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        link = sections[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("ArticleList") as! ArticleListController
        navigationController?.pushViewController(destination, animated: true)
        destination.feed = link
        destination.title = link
        destination.savedArticles = savedArticles
        destination.recentlyViewed = recentlyViewed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

    
    
    
    
}


