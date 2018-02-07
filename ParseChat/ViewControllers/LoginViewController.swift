//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Farid Ramos on 2/4/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    
    @IBAction func signUpBtn(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        loginUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkTextFields() -> Bool {
        
        let username = loginField.text ?? ""
        let password = pwField.text ?? ""
        
        if username.isEmpty {
            let alertController = UIAlertController(title: "Missing", message: "Enter Username Please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle case of user canceling. Doing nothing will dismiss the view.
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        if password.isEmpty {
            let alertController = UIAlertController(title: "Missing", message: "Enter Password Please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle case of user canceling. Doing nothing will dismiss the view.
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        return true
    }
    
    func registerUser() {
        // init a user object
        let newUser = PFUser()
        
        if !checkTextFields() {
            return
        }
        
        //set user properties
        newUser.username = loginField.text
        newUser.password = pwField.text
        
        newUser .signUpInBackground { (succeeded: Bool, error: Error?) in
            if let error = error{
                print("Error signing up \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Error", message: "Invalid sign up information", preferredStyle: .alert)
                
                //create a cancel action
                let cancelAction = UIAlertAction(title:"cancel", style: .cancel){
                    (action) in
                }
                
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
            }
            else{
                print("Successfully signed up")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    func loginUser() {
        let username = loginField.text ?? ""
        let password = pwField.text ?? ""
        
        if !checkTextFields() {
            return
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }
        
    }

}
