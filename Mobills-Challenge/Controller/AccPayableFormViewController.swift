//
//  AccPayableFormViewController.swift
//  Mobills-Challenge
//
//  Created by Mateus Nobre on 18/08/21.
//

import UIKit

class AccPayableFormViewController: UIViewController {

    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var ValueTextField: UITextField!
    @IBOutlet weak var DateDatePicker: UIDatePicker!
    var accPayable: AccountPayable?
    var save: ((_ newAccount: AccountPayable)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveData))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
        defineFormValue()
    }
    
    func defineFormValue() {
        guard let acc = accPayable else {return}
        DescriptionTextField.text = acc.description
        ValueTextField.text = String(format: "%.2f", acc.value)
        DateDatePicker.date = acc.date
    }
    
    func configureCell(accountPayable: AccountPayable, save: @escaping (_ newAccount: AccountPayable)->Void) {
        self.accPayable = accountPayable
        self.save = save
    }
    
    @objc
    func saveData() {
        navigationController?.dismiss(animated: true)
        guard let saveAction = save else {return}
        let description = DescriptionTextField.text ?? ""
        let value = Double(ValueTextField.text ?? "") ?? 0
        let saveAcc = AccountPayable(value: value, description: description, date: DateDatePicker.date, isPaid: false)
        saveAction(saveAcc)
    }
    
    @objc
    func cancel() {
        navigationController?.dismiss(animated: true)
    }

}
