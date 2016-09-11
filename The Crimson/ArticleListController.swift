//
//  ArticleListController.swift
//  The Crimson
//
//  Created by David Miller on 3/2/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ArticleListController: UITableViewController {
    
    // Create a variable to store the feed URL
    var feed = ""
    
    // Create a cache for the articles
    let cache = NSCache()
    
    // Create a list of NSManagedObjects to pass in the saved articles
    var savedArticles:[NSManagedObject] = []
    var recentlyViewed:[NSManagedObject] = []
    
    // Create arrays to store the articles and their html
    var articles = [Article]()
    var htmls = [String]()

    // Define link here so it's accessible by
    var link:String = ""
    
    // If the articles were successfully loaded
    var success = true
    
    // Button to clear history on Recently Viewed section
    @IBOutlet weak var clearHistory: UIBarButtonItem!
    
    @IBAction func clearHistoryPressed(sender: AnyObject) {
        
        let clearAlert = UIAlertController(title: "Clear History?", message: "All your recently viewed will be erased.", preferredStyle: UIAlertControllerStyle.Alert)
        
        if feed == "Saved for Later"
        {
            clearAlert.title = "Clear bookmarks?"
            clearAlert.message = "All your bookmarks will be erased."
        }
        
        clearAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            if self.feed == "Recently Viewed"
            {
                for item in self.recentlyViewed
                {
                    managedContext.deleteObject(item)
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
                self.recentlyViewed = []
                self.tableView.reloadData()
            }
            else if self.feed == "Saved for Later"
            {
                for item in self.savedArticles
                {
                    managedContext.deleteObject(item)
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
                self.savedArticles = []
                self.tableView.reloadData()
            }
            
        }))
        
        clearAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        
        presentViewController(clearAlert, animated: true, completion: nil)
    }
    
    // Create a function that loads the article objects into the articles array from the RSS
    func loadArticles() {
        articles = []
        if feed == "Saved for Later" {
            // make this read in the savedArticles
            //1
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "Article")
            
            //3
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                let managedArticles = results as! [NSManagedObject]
                for manArt in managedArticles {
                    let title = manArt.valueForKey("title") as! String
                    let subtitle = manArt.valueForKey("subtitle") as! String
                    let link = manArt.valueForKey("link") as! String
                    articles.append(Article(title: title, subtitle: subtitle, link: link)!)
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        } else if feed == "Recently Viewed" {
            //1
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            //2
            let fetchRequest = NSFetchRequest(entityName: "Recent")
            
            //3
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                let managedArticles = results as! [NSManagedObject]
                for manArt in managedArticles {
                    let title = manArt.valueForKey("title") as! String
                    let subtitle = manArt.valueForKey("subtitle") as! String
                    let link = manArt.valueForKey("link") as! String
                    articles.append(Article(title: title, subtitle: subtitle, link: link)!)
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        } else if feed.characters.contains(" ") {
            // This should only be triggered by Home Page and Top Stories
            return
        } else {
            // Load the RSS feed and splice it by item
            let url = NSURL(string: "http://www.thecrimson.com/feeds/section/" + feed + "/")
            let request = NSData(contentsOfURL: url!)
            if request == nil {
                self.success = false
                // To make a pop-up tell you you have no connection
                /*
                let alertController = UIAlertController(title: "Loading Failed!", message: "Please check your connection and try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler:nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                */
            } else {
                let html = NSString(data: request!, encoding: NSUTF8StringEncoding)
                let rss = html?.componentsSeparatedByString("<item>")
                // For all 25 articles, make an article object and store it in the arra
                for i in 1...25 {
                    let Title = (rss?[i].componentsSeparatedByString("<title>")[1])?.componentsSeparatedByString("</title>")[0]
                    let Description = (rss?[i].componentsSeparatedByString("<description>")[1])?.componentsSeparatedByString("</description>")[0]
                    let Link = (rss?[i].componentsSeparatedByString("<link>")[1])?.componentsSeparatedByString("</link>")[0]
                    articles.append(Article(title: Title!, subtitle: Description!, link: Link!)!)
                }
            }
        }
    }
    
    // Resizes cells to automatically fit content
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 800.0
        if !self.success {
            tableView.rowHeight = UIScreen.mainScreen().bounds.height - (navigationController?.navigationBar.frame.size.height)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadArticles()
        configureTableView()
        if feed != "Recently Viewed" && feed != "Saved for Later" {
            navigationItem.rightBarButtonItems = []
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feed == "Saved for Later" {
            return savedArticles.count
        } else if feed == "Recently Viewed" {
            return recentlyViewed.count
        } else if !success {
            // Format the backgroundView
            let loadingFailed = UILabel()
            loadingFailed.numberOfLines = 2
            if feed == "Saved for Later" {
                loadingFailed.text = "You have saved no articles.\nPress the star in the top-right corner to save an article."
            } else {
                loadingFailed.text = "Loading Failed!\nPlease check your connection and try again."
            }
            loadingFailed.textAlignment = NSTextAlignment.Center
            self.tableView.backgroundView = loadingFailed
            return 0
        } else {
            return articles.count
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if feed == "Saved for Later" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Article")
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                savedArticles = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        } else if feed == "Recently Viewed" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Recent")
            do {
                let results =
                    try managedContext.executeFetchRequest(fetchRequest)
                recentlyViewed = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        loadArticles()
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleListCell

        // Fetches appropriate article and fill the cell
        if feed == "Saved for Later" {
            let article = savedArticles[indexPath.row]
            cell.titleLabel!.text = article.valueForKey("title") as? String
            cell.descriptionLabel!.text = article.valueForKey("subtitle") as? String
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else if feed == "Recently Viewed" {
            let length = recentlyViewed.count
            let article = recentlyViewed[length - indexPath.row - 1]
            cell.titleLabel!.text = article.valueForKey("title") as? String
            cell.descriptionLabel!.text = article.valueForKey("subtitle") as? String
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else {
            let article = articles[indexPath.row]
            cell.titleLabel!.text = article.title
            cell.descriptionLabel!.text = article.subtitle
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let article = articles[indexPath.row]
        let link = articles[indexPath.row].link
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let destination = storyboard.instantiateViewControllerWithIdentifier("ArticleView") as! ArticleViewController
        navigationController?.pushViewController(destination, animated: true)
        
        destination.link = link
        destination.headline = article.title
        destination.byline = article.subtitle
        destination.savedArticles = savedArticles
        destination.recentlyViewed = recentlyViewed
        
        // Pull the html of the article from the cache if possible
        // Or else pull it from the web and store it in the cache
        do {
            let key = articles[indexPath.row].link
            if let cachedVersion = cache.objectForKey(key) as? String {
                // use the cached version
                destination.html = cachedVersion
            } else {
                // create it from scratch then store in the cache
                var html = try String(contentsOfURL: NSURL(string:link)!)
                
                // Cache it
                destination.html = html
                //destination.cleanseHtml()
                cache.setObject(destination.html, forKey: key)
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if feed == "Saved for Later" {
            switch editingStyle {
            case .Delete:
                // remove the deleted item from the model
                let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                context.deleteObject(savedArticles[indexPath.row] )
                savedArticles.removeAtIndex(indexPath.row)
                do {
                    try context.save()
                } catch _ {
                }
                // remove the deleted item from the `UITableView`
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
        }
    }
}

