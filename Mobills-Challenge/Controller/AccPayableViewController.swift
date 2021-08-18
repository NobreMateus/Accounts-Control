//
//  AccPayableViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 17/08/21.
//

import UIKit

class AccPayableViewController: UIViewController {

    @IBOutlet weak var AccPayableTableView: UITableView!
    
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
        let accPayableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        self.present(accPayableFormViewController, animated: true)
    }
}

extension AccPayableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccPayableTableView.dequeueReusableCell(withIdentifier: "accPayableCell", for: indexPath) as! AccPayableViewCell
        cell.accDescription.text = "Teste \(indexPath)"
        cell.accValueLabel.text = "R$25,00"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let payAction = UIContextualAction(style: .normal, title: "Pagar") { [weak self] (action, view, completionHandler) in
            print("Ok")
        }
        payAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [payAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            print("Delete")
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accPayableFormViewController = storyboard?.instantiateViewController(withIdentifier: "accPayableForm") as! UINavigationController
        self.present(accPayableFormViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
