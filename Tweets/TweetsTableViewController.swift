//
//  TweetsTableViewController.swift
//  Tweets
//
//  Created by Ilya Semerukhin on 02.09.2018.
//

import UIKit
import Twitter

class TweetsTableViewController: UITableViewController {
   
   private var tweets = [Array<Twitter.Tweet>]() {
      didSet {
         print(tweets)
      }
   }
   
   var searchText: String? {
      didSet {
         tweets.removeAll()
         tableView.reloadData()
         searchForTweets()
         title = searchText
      }
   }
   
   private func twitterRequest() -> Twitter.Request? {
      if let query = searchText, !query.isEmpty {
         return Twitter.Request(search: query, count: 100)
      }
      return nil
   }
   
   private var lastTwitterRequest: Twitter.Request?
   private func searchForTweets() {
      if let request = twitterRequest() {
         lastTwitterRequest = request
         request.fetchTweets { [weak self] newTweets in
            if request == self?.lastTwitterRequest {
               self?.tweets.insert(newTweets, at: 0)
            }
         }
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      searchText = "#appleinc"
   }
   
   // MARK: - UITableViewDataSource
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      // #warning Incomplete implementation, return the number of sections
      return 0
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return 0
   }
   
   /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
   
}






