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

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        cell.post = post
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
        
        query.findObjectsInBackground{ (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("My posts: \(posts)")
                self.posts = posts
            }
            else{
                print("Error \(String(describing: error?.localizedDescription))")
            }
            print("This is fun")
            self.tableView.reloadData()
        }
        print("I got here")
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        print("Trying to log out")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    
    }

}

