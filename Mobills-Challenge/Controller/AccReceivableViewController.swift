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
        let accReceivableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accReceivableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accReceivableFormViewController") as! AccReceivableFormViewController
        vc.configureCell(accountPayable: newAccount){ newAccount in
            self.repo.create(account: newAccount) { account in
                self.accountsReceivable.append(account)
                self.AccReceivableTableView.reloadData()
            }
        }
        accReceivableFormViewController.viewControllers.append(vc)
        self.present(accReceivableFormViewController, animated: true)
    }
}

extension AccReceivableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsReceivable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccReceivableTableView.dequeueReusableCell(withIdentifier: "accReceivableCell", for: indexPath) as! AccReceivableViewCell
        cell.configCell(account: accountsReceivable[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accReceivableFormNavigationController = storyboard?.instantiateViewController(withIdentifier: "accReceivableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accReceivableFormViewController") as! AccReceivableFormViewController
        
        vc.configureCell(accountPayable: accountsReceivable[indexPath.row]){ editedAccount in
            guard let accId = editedAccount.id else { return }
            self.repo.update(id: accId, account: editedAccount, completion: nil)
            self.accountsReceivable[indexPath.row] = editedAccount
            tableView.reloadData()
        }
        accReceivableFormNavigationController.viewControllers.append(vc)
        self.present(accReceivableFormNavigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let payAction = UIContextualAction(style: .normal, title: "Receber") { [weak self] (action, view, completionHandler) in
            guard let ctx = self else { return }
            guard let accId = ctx.accountsReceivable[indexPath.row].id else { return }
            ctx.accountsReceivable[indexPath.row].isReceived = true
            ctx.repo.update(id: accId, account: ctx.accountsReceivable[indexPath.row], completion: nil)
            ctx.accountsReceivable.remove(at: indexPath.row)
            ctx.AccReceivableTableView.reloadData()
        }
        payAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [payAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (action, view, completionHandler) in
            guard let ctx = self else { return }
            guard let accId = ctx.accountsReceivable[indexPath.row].id else { return }
            ctx.repo.delete(id: accId, nil)
            ctx.accountsReceivable.remove(at: indexPath.row)
            ctx.AccReceivableTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
