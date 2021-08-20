//
//  AccReceivableViewCell.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccReceivableViewCell: UITableViewCell {
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var ValueLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    func configCell(account: AccountReceivable) {
        DescriptionLabel.text = account.description
        ValueLabel.text = String(format: "R$ %.2f",account.value)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        let dateString = dateFormatter.string(from: account.date)
        DateLabel.text = dateString
        DateLabel.textColor = .systemGray
    }
    
}
