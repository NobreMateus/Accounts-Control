//
//  FireAuthRepo.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 19/08/21.
//

import Foundation
import Firebase

class FireAuthRepo {
    
    let auth = FirebaseAuth.Auth.auth()
    
    func createUser(email: String, pass: String) {
        auth.createUser(withEmail: email, password: pass) { result, err in
            
        }
    }
}
