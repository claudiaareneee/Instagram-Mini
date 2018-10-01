//
//  DetailViewController.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 10/1/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: PFObject!
    override func viewDidLoad() {
        super.viewDidLoad()

        if post.object(forKey: "author") != nil {
            let user = post.object(forKey: "author") as! PFUser
            usernameLabel.text = user.username
        }
        captionLabel.text = post["caption"] as? String
        timestampLabel.text = "\(String(describing: post.createdAt))"
        postImageView.file = post["media"] as? PFFile
        postImageView.loadInBackground()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
