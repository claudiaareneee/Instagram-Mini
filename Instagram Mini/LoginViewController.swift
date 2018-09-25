//
//  LoginViewController.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/24/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignInButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
//UNCOMMENT NEXTLINES 3
/*
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User login successful")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }
 */
    }
    
    @IBAction func onSingUpButton(_ sender: Any) {
//UNCOMMENT NEXTLINES 2
/*
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground{
            (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                // TODO: account for error 202
            } else {
                print("User registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
 */
    }

}
