//
//  AccSummaryViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccSummaryViewController: UIViewController {

    @IBOutlet weak var SummaryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTable()
    }
    
    func configureView() {
        title = "Resumo"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTable() {
        SummaryTable.delegate = self
        SummaryTable.dataSource = self
        SummaryTable.tableFooterView = UIView()
        SummaryTable.backgroundColor = .clear
    }
}

extension AccSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SummaryTable.dequeueReusableCell(withIdentifier: "accSummaryCell") as! AccSummaryViewCell
        if(indexPath.row == 0) {
            cell.configCell(title: "Contas a Pagar", amount: 10, total: 20.00)
        } else {
            cell.configCell(title: "Contas a Receber", amount: 20, total: 30.00)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
