//
//  AccPayableViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 17/08/21.
//

import UIKit

class AccPayableViewController: UIViewController {

    @IBOutlet weak var AccPayableTableView: UITableView!
    var accountsPayable: [AccountPayable] = []
    let fireRepo = FireRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureData()
    }
    
    func configureView() {
        title = "Contas a Pagar"
        navigationController?.navigationBar.prefersLargeTitles = true
        AccPayableTableView.delegate = self
        AccPayableTableView.dataSource = self
        AccPayableTableView.tableFooterView = UIView()
        AccPayableTableView.backgroundColor = .clear
        let addBtn = UIBarButtonItem(systemItem: .add)
        addBtn.action = #selector(addAccAction)
        addBtn.target = self
        navigationItem.rightBarButtonItem = addBtn
    }
    
    func configureData() {
        fireRepo.readAll{ accounts in
            self.accountsPayable = accounts
            self.AccPayableTableView.reloadData()
        }
    }
    
    @objc
    func addAccAction() {
        let newAccount = AccountPayable(value: 0, description: "", date: Date(), isPaid: false, id: nil)
        let accPayableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accPayableFormViewController") as! AccPayableFormViewController
        vc.configureCell(accountPayable: newAccount){ newAccount in
            self.fireRepo.create(account: newAccount) { account in
                self.accountsPayable.append(account)
                self.AccPayableTableView.reloadData()
            }
        }
        accPayableFormViewController.viewControllers.append(vc)
        self.present(accPayableFormViewController, animated: true)
    }
}

extension AccPayableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccPayableTableView.dequeueReusableCell(withIdentifier: "accPayableCell", for: indexPath) as! AccPayableViewCell
        cell.configCell(account: accountsPayable[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsPayable.count
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let payAction = UIContextualAction(style: .normal, title: "Pagar") { [weak self] (action, view, completionHandler) in
            guard let ctx = self else { return }
            guard let accId = ctx.accountsPayable[indexPath.row].id else { return }
            ctx.accountsPayable[indexPath.row].isPaid = true
            ctx.fireRepo.update(id: accId, account: ctx.accountsPayable[indexPath.row], completion: nil)
            ctx.accountsPayable.remove(at: indexPath.row)
            ctx.AccPayableTableView.reloadData()
        }
        payAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [payAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (action, view, completionHandler) in
            guard let ctx = self else { return }
            guard let accId = ctx.accountsPayable[indexPath.row].id else { return }
            ctx.fireRepo.delete(id: accId, nil)
            ctx.accountsPayable.remove(at: indexPath.row)
            ctx.AccPayableTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accPayableFormNavigationController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accPayableFormViewController") as! AccPayableFormViewController
        vc.configureCell(accountPayable: accountsPayable[indexPath.row]){ editedAccount in
            guard let accId = editedAccount.id else { return }
            self.fireRepo.update(id: accId, account: editedAccount, completion: nil)
            self.accountsPayable[indexPath.row] = editedAccount
            tableView.reloadData()
        }
        accPayableFormNavigationController.viewControllers.append(vc)
        self.present(accPayableFormNavigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
