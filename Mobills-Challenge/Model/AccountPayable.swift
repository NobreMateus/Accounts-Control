//
//  AccountPayable.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import Foundation

class AccountPayable {
    
    var value: Double
    var description: String
    var date: Date
    var isPaid: Bool

    init(value: Double, description: String, date: Date, isPaid: Bool) {
        self.value = value
        self.description = description
        self.date = date
        self.isPaid = isPaid
    }
}   
