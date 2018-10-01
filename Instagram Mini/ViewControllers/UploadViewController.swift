//
//  UploadViewController.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/29/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var imagePostIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
    }
    
    //This method takes picture with camera
    @IBAction func takePicture(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }
    
    //This method selects a photo from the camera roll
    @IBAction func selectPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //This image gets the seleted image and sets an image view with that image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        let editedImage = resize(image: image, newSize: CGSize(width: 512, height: 512))
        
        print("original image size: \(editedImage.size)")
        
        imagePostIV.image = editedImage
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }

    @IBAction func postImage(_ sender: Any) {
        Post.postUserImage(image: imagePostIV.image, withCaption: captionTextField.text) { (success, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                print("Successful")
            }
            self.performSegue(withIdentifier: "uploadedPost", sender: nil)
        }
        
    }
    
    //This dismisses the keyboard when hitting the 'done' button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        captionTextField.resignFirstResponder()
        return true
    }
    
    //This dismisses the keyboard when touching out of textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
