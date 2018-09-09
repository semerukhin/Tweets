//
//  DBTweetsTableViewController.swift
//  Tweets
//
//  Created by Ilya Semerukhin on 09.09.2018.
//

import UIKit
import Twitter
import CoreData

class DBTweetsTableViewController: TweetsTableViewController {
   
   var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
   
   override func insertTweets(_ newTweets: [Twitter.Tweet]) {
      super.insertTweets(newTweets)
      updateDatabase(with: newTweets)
   }
   
   private func updateDatabase(with tweets: [Twitter.Tweet]) {
      print("Starting database load")
      container?.performBackgroundTask { [weak self] context in
         for twitterInfo in tweets {
            _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
         }
         try? context.save()
         print("Done loading database")
         self?.printDatabaseStatistics()
      }
   }
   
   private func printDatabaseStatistics() {
      if let context = container?.viewContext {
         context.perform {
            if Thread.isMainThread {
               print("On main thread")
            } else {
               print("Off main thread")
            }
            if let tweetCount = (try? context.fetch(Tweet.fetchRequest()))?.count {
               print("\(tweetCount) tweets")
            }
            if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest()) {
               print("\(tweeterCount) twitter users")
            }
         }
      }
   }
   
}






