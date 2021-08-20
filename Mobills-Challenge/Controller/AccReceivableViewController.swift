//
//  AccReceivableViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccReceivableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var AccReceivableTableView: UITableView!
    var accountsReceivable: [AccountReceivable] = []
    let repo = FireAccReceivableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureData()
    }
    
    func configureView() {
        title = "Contas a Receber"
        navigationController?.navigationBar.prefersLargeTitles = true
        AccReceivableTableView.delegate = self
        AccReceivableTableView.dataSource = self
        let addBtn = UIBarButtonItem(systemItem: .add)
        addBtn.action = #selector(addAccAction)
        addBtn.target = self
        navigationItem.rightBarButtonItem = addBtn
    }
    
    func configureData() {
        repo.readAll{ accounts in
            self.accountsReceivable = accounts
            self.AccReceivableTableView.reloadData()
        }
    }
    
    @objc
    func addAccAction() {
        let newAccount = AccountReceivable(value: 0, description: "", date: Date(), isReceived: false, id: nil)
        let accPayableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accPayableFormViewController") as! AccPayableFormViewController
//        vc.configureCell(accountPayable: newAccount){ newAccount in
//            self.repo.create(account: newAccount) { account in
//                self.accountsPayable.append(account)
//                self.AccPayableTableView.reloadData()
//            }
//        }
        accPayableFormViewController.viewControllers.append(vc)
        self.present(accPayableFormViewController, animated: true)
    }
}

extension AccReceivableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccReceivableTableView.dequeueReusableCell(withIdentifier: "accReceivableCell", for: indexPath) as! AccReceivableViewCell
        cell.DescriptionLabel.text = "Teste"
        cell.ValueLabel.text = "R$25,00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
