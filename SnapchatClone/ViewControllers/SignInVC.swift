//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 10.10.2023.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    @objc func hideKeyboard() {
            // Klavyeyi gizle
            self.view.endEditing(true)
        }
    
    @IBAction func signinButtonClicked(_ sender: Any) {
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
    }
}

