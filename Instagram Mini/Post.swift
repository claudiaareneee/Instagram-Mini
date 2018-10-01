//
//  Post.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/30/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    //Required Function
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?){
        
        let post = Post()
        post.media = getPFFileFromImage(image: image)!
        post.author = PFUser.current()!
        if let caption = caption{
            post.caption = caption
        }
        post.likesCount = 0
        post.commentsCount = 0
        
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData =  image.pngData(){
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
}
