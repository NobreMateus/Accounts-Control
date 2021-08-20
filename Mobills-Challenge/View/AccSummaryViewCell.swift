//
//  AccSummaryViewCell.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 20/08/21.
//

import UIKit

class AccSummaryViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    
    func configCell(title: String, amount: Int, total: Double) {
        TitleLabel.text = title
        AmountLabel.text = String(format: "Quantidade: %d", amount)
        TotalLabel.text = String(format: "R$ %.2f", total)
    }
    
}
