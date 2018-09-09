//
//  TweetersTableViewController.swift
//  Tweets
//
//  Created by Ilya Semerukhin on 09.09.2018.
//

import UIKit
import CoreData

class TweetersTableViewController: UITableViewController {
   
   var mention: String? { didSet { updateUI() } }
   var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer { didSet { updateUI() } }
   
   private func updateUI() {
      
   }
   
}






