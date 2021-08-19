//
//  AccPayableRepositoryProtocol.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 19/08/21.
//

import Foundation

protocol AccPayableRepositoryProtocol {
    func create(account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?)
    func read(id: String, account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?)
    func update(id: String, account: AccountPayable, completion: ((_ account: AccountPayable)->Void)?)
    func delete(id: String, _ completion: (()->Void)?)
    func readAll(completion: ((_ accounts: [AccountPayable])->Void)?)
}
