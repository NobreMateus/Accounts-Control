//
//  FireAccReceivableRepository.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 20/08/21.
//

import Foundation
import Firebase

class FireAccReceivableRepository {
    
    let db = Firestore.firestore()
    let auth = FirebaseAuth.Auth.auth()
    let user: User?
    let usersCollection = "users"
    let accountsCollection = "accountsReceivable"
    
    init() {
        user = auth.currentUser
    }
    
    func create(account: AccountReceivable, completion: ((_ account: AccountReceivable)->Void)?) {
        guard let currentUser = user else { return }
        let uid = currentUser.uid
        var ref: DocumentReference? = nil
        ref = db.collection(usersCollection).document(uid).collection(accountsCollection).addDocument(data: [
            "description": account.description,
            "value": account.value,
            "date": account.date,
            "isReceived": account.isReceived
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                account.id = ref?.documentID
                completion?(account)
            }
        }
    }
    
    func read(id: String, account: AccountReceivable, completion: ((_ account: AccountReceivable)->Void)?) {
        guard let currentUser = user else { return }
        let uid = currentUser.uid
        db.collection("users").document(uid).collection(accountsCollection).document(id).getDocument{ (snap, err) in
            guard let currentSnap = snap else { return }
            let acc = AccountReceivable(
                value: 0,
                description: "",
                date: Date(),
                isReceived: false,
                id: currentSnap.documentID
            )
            guard let data = currentSnap.data() else { return }
            if let value = data["value"] as? Double { acc.value = value }
            if let description = data["description"] as? String { acc.description = description }
            if let date = data["date"] as? Date { acc.date = date }
            if let isReceived = data["isReceived"] as? Bool { acc.isReceived = isReceived }
        }
    }
    
    func update(id: String, account: AccountReceivable, completion: ((_ account: AccountReceivable)->Void)?) {
        guard let currentUser = user else { return }
        let uid = currentUser.uid
        db.collection(usersCollection).document(uid).collection(accountsCollection).document(id).updateData([
            "description": account.description,
            "value": account.value,
            "date": account.date,
            "isReceived": account.isReceived
        ])
        completion?(account)
    }
    
    func delete(id: String, _ completion: (()->Void)?) {
        guard let currentUser = user else { return }
        let uid = currentUser.uid
        db.collection(usersCollection).document(uid).collection(accountsCollection).document(id).delete()
    }
    
    func readAll(completion: ((_ accounts: [AccountReceivable])->Void)?) {
        guard let currentUser = user else { return }
        let uid = currentUser.uid
        db.collection(usersCollection).document(uid).collection(accountsCollection).getDocuments { (snap, err) in
            var allAccounts: [AccountReceivable] = []
            for doc in snap!.documents {
                let account = AccountReceivable(
                    value: 0,
                    description: "",
                    date: Date(),
                    isReceived: false,
                    id: doc.documentID
                )
                let data = doc.data()
                if let value = data["value"] as? Double { account.value = value }
                if let description = data["description"] as? String { account.description = description }
                if let date = data["date"] as? Timestamp { account.date = date.dateValue() }
                if let isReceived = data["isReceived"] as? Bool { account.isReceived = isReceived }
                allAccounts.append(account)
            }
            completion?(allAccounts)
        }
    }
}
