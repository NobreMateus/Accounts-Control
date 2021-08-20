//
//  AccPayableViewCell.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 17/08/21.
//

import UIKit

class AccPayableViewCell: UITableViewCell {

    @IBOutlet weak var accDescription: UILabel!
    @IBOutlet weak var accValueLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    func configCell(account: AccountPayable) {
        accDescription.text = account.description
        accValueLabel.text = String(format: "R$ %.2f", account.value)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        DateLabel.text = dateFormatter.string(from: account.date)
    }
    
}
