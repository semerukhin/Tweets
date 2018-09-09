//
//  TweetsTableViewController.swift
//  Tweets
//
//  Created by Ilya Semerukhin on 02.09.2018.
//

import UIKit
import Twitter

class TweetsTableViewController: UITableViewController, UITextFieldDelegate {
   
   private var tweets = [Array<Twitter.Tweet>]() // { didSet { print(tweets) } }
   
   var searchText: String? {
      didSet {
         searchTextField?.text = searchText
         searchTextField?.resignFirstResponder()
         lastTwitterRequest = nil
         tweets.removeAll()
         tableView.reloadData()
         searchForTweets()
         title = searchText
      }
   }
   
   private func twitterRequest() -> Twitter.Request? {
      if let query = searchText, !query.isEmpty {
         return Twitter.Request(search: "\(query) -filter:safe -filter:retweets", count: 100)
      }
      return nil
   }
   
   private var lastTwitterRequest: Twitter.Request?
   
   private func searchForTweets() {
      if let request = lastTwitterRequest?.newer ?? twitterRequest() {
         lastTwitterRequest = request
         request.fetchTweets { [weak self] newTweets in
            DispatchQueue.main.async {
               if request == self?.lastTwitterRequest {
                  self?.tweets.insert(newTweets, at: 0)
                  self?.tableView.insertSections([0], with: .fade)
               }
               self?.refreshControl?.endRefreshing()
            }
         }
      } else {
         self.refreshControl?.endRefreshing()
      }
   }
   
   @IBAction func refresh(_ sender: UIRefreshControl) {
      searchForTweets()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.estimatedRowHeight = tableView.rowHeight
      tableView.rowHeight = UITableViewAutomaticDimension
   }
   
   @IBOutlet weak var searchTextField: UITextField! {
      didSet {
         searchTextField.delegate = self
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == searchTextField {
         searchText = searchTextField.text
      }
      return true
   }
   
   // MARK: - UITableViewDataSource
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return tweets.count
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets[section].count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)
      let tweet: Tweet = tweets[indexPath.section][indexPath.row]
      // cell.textLabel?.text = tweet.text
      // cell.detailTextLabel?.text = tweet.user.name
      if let tweetCell = cell as? TweetsTableViewCell {
         tweetCell.tweet = tweet
      }
      return cell
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return "\(tweets.count - section)"
   }
   
}






