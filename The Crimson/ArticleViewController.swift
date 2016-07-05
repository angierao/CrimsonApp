//
//  ArticleViewController.swift
//  The Crimson
//
//  Created by David Miller on 3/3/16.
//  Copyright © 2016 The Crimson. All rights reserved.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var link: String = "http://www.thecrimson.com/404"
    var html: String = "<h1>Error occured :(</h1>"
    
    var headline: String = "Title"
    var byline: String = "by David Miller"
    var date: String = "June 21, 2016"
    var text: String = "Text"
    
    var saved: Bool = false
    
    var savedArticles = [NSManagedObject]()
    var recentlyViewed = [NSManagedObject]()
    
    func updateSavedAppearance()
    {
        if saved
        {
            saveButton.style = UIBarButtonItemStyle.Done
            saveButton.image = UIImage(named: "star-filled")
        } else {
            saveButton.style = UIBarButtonItemStyle.Plain
            saveButton.image = UIImage(named: "star")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the title blank
        self.navigationItem.title = ""
        
        // Load the html into the webView
        webView.loadHTMLString(html, baseURL: nil)
        
        // Load the managedContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Load savedArticles from memory
        let saveFetch = NSFetchRequest(entityName: "Article")
        do {
            let results = try managedContext.executeFetchRequest(saveFetch)
            savedArticles = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // Load recentlyViewed from memeory
        let recentFetch = NSFetchRequest(entityName: "Recent")
        do {
            let results = try managedContext.executeFetchRequest(recentFetch)
            recentlyViewed = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // See if the article is already saved
        var links:[String] = []
        for article in savedArticles
        {
            links.append(article.valueForKey("link") as! String)
        }
        self.saved = links.contains(link)
        updateSavedAppearance()
        
        // Add the article to recentlyViewed
        let entity =  NSEntityDescription.entityForName("Recent", inManagedObjectContext:managedContext)
        let article = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        article.setValue(headline, forKey: "title")
        article.setValue(byline, forKey: "subtitle")
        article.setValue(link, forKey: "link")
        recentlyViewed.insert(article, atIndex: (recentlyViewed.count))
        if recentlyViewed.count > 10 {
            managedContext.deleteObject(recentlyViewed[0])
            recentlyViewed.removeAtIndex(0)
        }
        do {
            try managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
        
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        print(self.saved)
        if !self.saved
        {
            let entity =  NSEntityDescription.entityForName("Article", inManagedObjectContext:managedContext)
            let article = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            article.setValue(headline, forKey: "title")
            article.setValue(byline, forKey: "subtitle")
            article.setValue(link, forKey: "link")
            do {
                try managedContext.save()
                savedArticles.append(article)
                self.saved = true
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        } else {
            let fetchRequest = NSFetchRequest(entityName: "Article")
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                let managedArticles = results as! [NSManagedObject]
                var index = 0
                for (num, manArt) in managedArticles.enumerate()
                {
                    if String(manArt.valueForKey("link")) == self.link
                    {
                        index = num
                    }
                }
                managedContext.deleteObject(savedArticles[index])
                savedArticles.removeAtIndex(index)
                try managedContext.save()
                self.saved = false
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        updateSavedAppearance()
    }
    
    @IBAction func sharePressed(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let copyURL = UIAlertAction(title: "Copy URL", style: .Default) {
            (_) in
            // Copy the URL to the clipboard
            UIPasteboard.generalPasteboard().string = self.link
        }
        let openSafari = UIAlertAction(title: "Open in Safari", style: .Default) {
            (_) in
            // Open the link in Safari
            UIApplication.sharedApplication().openURL(NSURL(string: self.link)!)
        }
        let shareOther = UIAlertAction(title: "Share", style: .Default) {
            (_) in
            // Share the article link with a short message
            let message = "Check out this article from The Crimson!\n\n" + self.link
            let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) {
            (_) in
            return
        }
        alertController.addAction(copyURL)
        alertController.addAction(openSafari)
        alertController.addAction(shareOther)
        alertController.addAction(cancel)
        self.presentViewController(alertController, animated: true) {}
    }
    
}
