//
//  LoginViewController.swift
//  Instagram Mini
//
//  Created by Claudia Nelson on 9/24/18.
//  Copyright © 2018 Claudia Nelson. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    //User clicks sign in button and signs in user using parse
    @IBAction func onSignInButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                //Account for error 202
            } else {
                print("User login successful")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    //User clicks sign up button and creates new user using parse
    @IBAction func onSingUpButton(_ sender: Any) {

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
    }
    
    
    //This dismisses the keyboard when hitting the 'done' button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    //This dismisses the keyboard when touching out of textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

}
