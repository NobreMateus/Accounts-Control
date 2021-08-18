//
//  AccReceivableViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccReceivableViewController: UIViewController {
    
    @IBOutlet weak var AccReceivableTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contas a Receber"
        navigationController?.navigationBar.prefersLargeTitles = true
        AccReceivableTableView.delegate = self
        AccReceivableTableView.dataSource = self
    }
}

extension AccReceivableViewController: UITableViewDelegate, UITableViewDataSource {
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
