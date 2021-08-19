//
//  FireRepository.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 19/08/21.
//

import Foundation
import Firebase

class FireRepository: AccPayableRepositoryProtocol {
    
    let db = Firestore.firestore()
    
    func create(account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?) {
        var ref: DocumentReference? = nil
        ref = db.collection("accountsPayable").addDocument(data: [
            "description": account.description,
            "value": account.value,
            "date": account.date,
            "isPaid": account.isPaid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                account.id = ref?.documentID
                completion?(account)
            }
        }
    }
    
    func read(id: String, account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?) {
        db.collection("accountsPayable").document(id).getDocument{ (snap, err) in
            guard let currentSnap = snap else { return }
            let acc = AccountPayable(
                value: 0,
                description: "",
                date: Date(),
                isPaid: false,
                id: currentSnap.documentID
            )
            guard let data = currentSnap.data() else { return }
            if let value = data["value"] as? Double { acc.value = value }
            if let description = data["description"] as? String { acc.description = description }
            if let date = data["date"] as? Date { acc.date = date }
            if let isPaid = data["isPaid"] as? Bool { acc.isPaid = isPaid }
        }
    }
    
    func update(id: String, account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?) {
        db.collection("accountsPayable").document(id).updateData([
            "description": account.description,
            "value": account.value,
            "date": account.date,
            "isPaid": account.isPaid
        ])
        completion?(account)
    }
    
    func delete(id: String, _ completion: (()->Void)?) {
        db.collection("accountsPayable").document(id).delete()
    }
    
    func readAll(completion: ((_ accounts: [AccountPayable])->Void)?) {
        db.collection("accountsPayable").getDocuments { (snap, err) in
            var allAccounts: [AccountPayable] = []
            for doc in snap!.documents {
                let account = AccountPayable(
                    value: 0,
                    description: "",
                    date: Date(),
                    isPaid: false,
                    id: doc.documentID
                )
                let data = doc.data()
                if let value = data["value"] as? Double { account.value = value }
                if let description = data["description"] as? String { account.description = description }
                if let date = data["date"] as? Timestamp { account.date = date.dateValue() }
                if let isPaid = data["isPaid"] as? Bool { account.isPaid = isPaid }
                allAccounts.append(account)
            }
            completion?(allAccounts)
        }
    }
    
}
