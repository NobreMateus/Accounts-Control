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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        EnterButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc
    func login() {
        let handler = Firebase.Auth.auth()
        handler.signIn(withEmail: "mateus@mateus.com", password: "123456"){(result, err) in
            result?.user
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let handler = Firebase.Auth.auth()
        handler.addStateDidChangeListener(){ (auth, user) in
            guard user != nil else { return }
            self.performSegue(withIdentifier: "AppEnterSegue", sender: nil)
            print(user!.email)
        }
    }

  
}
