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
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        title = "Contas a Pagar"
        navigationController?.navigationBar.prefersLargeTitles = true
        AccPayableTableView.delegate = self
        AccPayableTableView.dataSource = self
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
}
