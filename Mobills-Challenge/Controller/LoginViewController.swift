//
//  LoginViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 19/08/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LoginTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var EnterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnterButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc
    func login() {
        let handler = Firebase.Auth.auth()
        let email = LoginTextField.text
        let password = PassTextField.text
        handler.signIn(withEmail: email!, password: password!)
    }

  
}
