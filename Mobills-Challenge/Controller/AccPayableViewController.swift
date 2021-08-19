//
//  AccPayableViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 17/08/21.
//

import UIKit

class AccPayableViewController: UIViewController {

    @IBOutlet weak var AccPayableTableView: UITableView!
    var accountsPayable = [
        AccountPayable(value: 10, description: "Merenda", date: Date(), isPaid: false),
        AccountPayable(value: 10, description: "Merenda", date: Date(), isPaid: false),
        AccountPayable(value: 10, description: "Merenda", date: Date(), isPaid: false),
        AccountPayable(value: 10, description: "Merenda", date: Date(), isPaid: false),
        AccountPayable(value: 10, description: "Merenda", date: Date(), isPaid: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        title = "Contas a Pagar"
        navigationController?.navigationBar.prefersLargeTitles = true
        AccPayableTableView.delegate = self
        AccPayableTableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc
    func addTapped() {
        let newAccount = AccountPayable(value: 0, description: "", date: Date(), isPaid: false)
        let accPayableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accPayableFormViewController") as! AccPayableFormViewController
        vc.configureCell(accountPayable: newAccount){ newAccount in
            self.accountsPayable.append(newAccount)
            self.AccPayableTableView.reloadData()
        }
        accPayableFormViewController.viewControllers.append(vc)
        self.present(accPayableFormViewController, animated: true)
    }
}

extension AccPayableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccPayableTableView.dequeueReusableCell(withIdentifier: "accPayableCell", for: indexPath) as! AccPayableViewCell
        cell.accDescription.text = accountsPayable[indexPath.row].description
        cell.accValueLabel.text = "R$ \(String(format: "%.2f", accountsPayable[indexPath.row].value))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsPayable.count
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let payAction = UIContextualAction(style: .normal, title: "Pagar") { [weak self] (action, view, completionHandler) in
            self?.accountsPayable.remove(at: indexPath.row)
            self?.AccPayableTableView.reloadData()
        }
        payAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [payAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.accountsPayable.remove(at: indexPath.row)
            self?.AccPayableTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accPayableFormNavigationController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        let vc = storyboard?.instantiateViewController(withIdentifier: "accPayableFormViewController") as! AccPayableFormViewController
        vc.configureCell(accountPayable: accountsPayable[indexPath.row]){ editedAccount in
            self.accountsPayable[indexPath.row] = editedAccount
            tableView.reloadData()
        }
        accPayableFormNavigationController.viewControllers.append(vc)
        self.present(accPayableFormNavigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
