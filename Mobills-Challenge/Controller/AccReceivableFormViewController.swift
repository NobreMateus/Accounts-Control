//
//  AccReceivableFormViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 20/08/21.
//

import UIKit

class AccReceivableFormViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var DateDatePicker: UIDatePicker!
    
    var accReceivable: AccountReceivable?
    var save: ((_ newAccount: AccountReceivable)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
        defineFormValue()
    }
    
    func defineFormValue() {
        guard let acc = accReceivable else {return}
        descriptionTextField.text = acc.description
        valueTextField.text = String(format: "%.2f", acc.value)
        DateDatePicker.date = acc.date
    }

    func configureCell(accountPayable: AccountReceivable, save: @escaping (_ newAccount: AccountReceivable)->Void) {
        self.accReceivable = accountPayable
        self.save = save
    }
    
    @objc
    func saveData() {
        guard let currentAccount = self.accReceivable else { return }
        navigationController?.dismiss(animated: true)
        guard let saveAction = save else { return }
        let description = descriptionTextField.text ?? ""
        let value = Double(valueTextField.text ?? "") ?? 0
        let saveAcc = AccountReceivable(value: value, description: description, date: DateDatePicker.date, isReceived: false, id: currentAccount.id)
        saveAction(saveAcc)
    }
    
    @objc
    func cancel() {
        navigationController?.dismiss(animated: true)
    }

}
