//
//  AccountReceivable.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import Foundation

class AccountReceivable {
    
    var value: Double
    var description: String
    var date: Date
    var isReceived: Bool

    init(value: Double, description: String, date: Date, isReceived: Bool) {
        self.value = value
        self.description = description
        self.date = date
        self.isReceived = isReceived
    }
}
