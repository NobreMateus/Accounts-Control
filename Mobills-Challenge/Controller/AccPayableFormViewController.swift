//
//  AccPayableFormViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccPayableFormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
    }
    
    @objc
    func saveData() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc
    func cancel() {
        navigationController?.dismiss(animated: true)
    }

}
