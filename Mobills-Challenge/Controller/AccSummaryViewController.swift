//
//  AccSummaryViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit
import Firebase

class AccSummaryViewController: UIViewController {

    @IBOutlet weak var SummaryTable: UITableView!
    let accReceivableRepo = FireAccReceivableRepository()
    let accPayableRepo = FireRepository()
    var accountsReceivable: [AccountReceivable] = []
    var accountsPayable: [AccountPayable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureData()
    }
    
    func configureView() {
        title = "Resumo"
        navigationController?.navigationBar.prefersLargeTitles = true
        let addBtn = UIBarButtonItem(systemItem: .close)
        addBtn.action = #selector(logOut)
        addBtn.target = self
        navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc
    func logOut() {
        let handler = Firebase.Auth.auth()
        do {
            try handler.signOut()
        } catch {}
    }
    
    func configureTable() {
        SummaryTable.delegate = self
        SummaryTable.dataSource = self
        SummaryTable.tableFooterView = UIView()
        SummaryTable.backgroundColor = .clear
    }
    
    func configureData() {
        accPayableRepo.readAll { accounts in
            self.accountsPayable = accounts
            self.SummaryTable.reloadData()
        }
        accReceivableRepo.readAll { accounts in
            self.accountsReceivable = accounts
            self.SummaryTable.reloadData()
        }
    }
}

extension AccSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SummaryTable.dequeueReusableCell(withIdentifier: "accSummaryCell") as! AccSummaryViewCell
        let receivableTotal = self.accountsReceivable.reduce(0, { partial, item in partial + item.value })
        let payableTotal = self.accountsPayable.reduce(0, { partial, item in partial + item.value })
        if(indexPath.row == 0) {
            cell.configCell(title: "Contas a Pagar", amount: self.accountsPayable.count, total: payableTotal)
        } else {
            cell.configCell(title: "Contas a Receber", amount: self.accountsReceivable.count, total: receivableTotal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
