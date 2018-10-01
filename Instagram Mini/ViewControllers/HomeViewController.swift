//
//  HomeViewController.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/29/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject] = []
    let refreshControl = UIRefreshControl()
//    var isMoreDataLoading = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initialize a UIRefreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        
        tableView.dataSource = self
        fetchPosts()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        
        if post.object(forKey: "author") != nil {
            let user = post.object(forKey: "author") as! PFUser
            cell.usernameLabel.text = user.username
        }
        cell.commentLabel.text = post["caption"] as? String
        cell.postImageView.file = post["media"] as? PFFile
        cell.postImageView.loadInBackground()

        return cell
    }
    
    func fetchPosts(){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //Asynchronously find more images
        query.findObjectsInBackground{ (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("My posts: \(posts)")
                self.posts = posts
                self.refreshControl.endRefreshing()
            }
            else{
                print("Error \(String(describing: error?.localizedDescription))")
            }
            self.tableView.reloadData()
        }
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell =  sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.post = post
        }
    }
    
    
    
    
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//         if !isMoreDataLoading {
//            // Calculate the position of one screen length before the bottom of the results
//            let scrollViewContentHeight = tableView.contentSize.height
//            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
//
//            // When the user has scrolled past the threshold, start requesting
//            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging{
//                isMoreDataLoading = true
//            }
//        }
//    }
}

