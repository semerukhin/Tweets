//
//  TweetsTableViewCell.swift
//  Tweets
//
//  Created by Ilya Semerukhin on 09.09.2018.
//

import UIKit
import Twitter

class TweetsTableViewCell: UITableViewCell {
   
   @IBOutlet weak var tweetUserLabel: UILabel!
   @IBOutlet weak var tweetTextLabel: UILabel!
   @IBOutlet weak var tweetProfileImageView: UIImageView!
   @IBOutlet weak var tweetCreatedLabel: UILabel!
   
   var tweet: Twitter.Tweet? { didSet { updateUI() } }
   
   private func updateUI() {
      tweetTextLabel?.text = tweet?.text
      tweetUserLabel?.text = tweet?.user.description
      
      if let profileImageURL = tweet?.user.profileImageURL {
         // FIXME: blocks main thread
         if let imageData = try? Data(contentsOf: profileImageURL) {
            tweetProfileImageView?.image = UIImage(data: imageData)
         }
      } else {
         tweetProfileImageView?.image = nil
      }
      
      if let created = tweet?.created {
         let formatter = DateFormatter()
         if Date().timeIntervalSince(created) > 24*60*60 {
            formatter.dateStyle = .short
         } else {
            formatter.timeStyle = .short
         }
         tweetCreatedLabel?.text = formatter.string(from: created)
      } else {
         tweetCreatedLabel?.text = nil
      }
   }
   
}






