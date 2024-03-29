//
//  EfetivacaoViewController.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 04/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class EfetivacaoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableviewConta: UITableView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonTen: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    
    @IBOutlet weak var buttonVoltar: UIButton!
    
    @IBOutlet weak var agenciaLabel: UILabel!
    @IBOutlet weak var contaLabel: UILabel!
    
    var numTextField: Double = 0.00
    var numSet: Double = 0.00

    let modelSaldo: Saldo = Saldo()
    let efetivacaoController = EfetivacaoController()
    var name: String?
    var agencia: String?
    var conta: String?
    var saldo: String?
    var saldoContaSelecionada: Double?
    var saldoAtualFinal: Double = 0.00
    var indexContaSelecionada: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.valueTextField.delegate = self
        self.tableviewConta.dataSource = self
        
        setupLayout()
        setupObservers()
        setupKeyboardToolbar()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    func setupLayout() {
        if let name = name{
            contactNameLabel.text = name
        }
        if let agencia = agencia{
            agenciaLabel.text = "agência: \(agencia)"
        }
        if let conta = conta{
            contaLabel.text = "conta: \(conta)"
        }
        
        valueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
        valueTextField.borderStyle = UITextField.BorderStyle.none
        valueTextField.layer.borderWidth = 0
        
        buttonOne.backgroundColor = .clear
        buttonOne.layer.cornerRadius = 7
        buttonOne.layer.borderWidth = 1
        buttonOne.layer.borderColor = UIColor.orange.cgColor
        
        buttonFive.backgroundColor = .clear
        buttonFive.layer.cornerRadius = 7
        buttonFive.layer.borderWidth = 1
        buttonFive.layer.borderColor = UIColor.orange.cgColor
        
        buttonTen.backgroundColor = .clear
        buttonTen.layer.cornerRadius = 7
        buttonTen.layer.borderWidth = 1
        buttonTen.layer.borderColor = UIColor.orange.cgColor
        
        buttonConfirm.backgroundColor = .orange
        buttonConfirm.layer.cornerRadius = 7
        
        buttonVoltar.backgroundColor = .clear
        buttonVoltar.layer.cornerRadius = 7
        buttonVoltar.layer.borderWidth = 1
        buttonVoltar.layer.borderColor = UIColor.orange.cgColor
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    func setupKeyboardToolbar() {
        let bar = UIToolbar()
        bar.sizeToFit()
        let ok = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(onClickOkKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexibleSpace,ok]
        valueTextField.inputAccessoryView = bar
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = valueTextField.text?.currencyInputFormatting() {
            valueTextField.text = amountString
        }
    }

    
    @objc func keyboardWillChange (notification: Notification) {
       view.frame.origin.y = -160
    }
    
    @objc func onClickOkKeyboard(){
        view.endEditing(true)
        view.frame.origin.y = 0
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == valueTextField{
            valueTextField.becomeFirstResponder()
        }else{
            valueTextField.resignFirstResponder()
        }
    }
    
    
    @IBAction func buttonOne(_ sender: UIButton) {
        if let value = Double(valueTextField.text!){
        numTextField = value + 1
            self.valueTextField.text = String(format: "%0.2f", numTextField)
        }else{
            numTextField += 1
            self.valueTextField.text = String(format: "%0.2f", numTextField)
        }
    }
    

    @IBAction func buttonFive(_ sender: UIButton) {
        if let value = Double(valueTextField.text!) {
            numTextField = value + 5
            self.valueTextField.text =  String(format: "%0.2f", numTextField)
        } else {
            numTextField += 5
            self.valueTextField.text =  String(format: "%0.1f", numTextField)
        }
    }
    

    @IBAction func buttonTen(_ sender: UIButton) {
        if let value = Double(valueTextField.text!){
            numTextField = value + 10
            self.valueTextField.text = String(format: "%0.2f", numTextField)
        }else{
            numTextField += 10
            self.valueTextField.text = String(format: "%0.1f", numTextField)
        }
    }
    
    
    @IBAction func buttonClean(_ sender: UIButton) {
        numTextField = 0.00
        self.valueTextField.text = "\(numTextField)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.frame.origin.y = 0
    }
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        guard let value = Double(valueTextField.text!) else {
            let erro = ValidationError(titleError: "Atenção", messageError: "Digite um valor.")
            self.showError(error: erro, buttonLabel: "OK")
            return
        }
        
        if value > 10000.00 {
         let erro = ValidationError(titleError: "Atenção", messageError: "Transferência máxima permitida no valor de R$ 10.000,00 reais. Insira um valor menor!")
            self.showError(error: erro, buttonLabel: "OK")
        }else{
            
            if value != 0{
                let erro = ValidationError(titleError: "Sucesso", messageError: "A sua transferência foi realizada com sucesso!")
                
                showErrorAction(error: erro, buttonLabel: "OK") {
                    let saldoatual = SaldoShared.shared.arraySaldos[self.indexContaSelecionada ?? 0]
                    
                    SaldoShared.shared.arraySaldos[self.indexContaSelecionada ?? 0] = saldoatual - value
                    
                    self.dismiss(animated: true, completion: nil)
                    self.valueTextField.resignFirstResponder()
                    self.view.frame.origin.y = 0
                }
            }else{
                let erro = ValidationError(titleError: "Atenção", messageError: "Digite um valor.")
                self.showError(error: erro, buttonLabel: "OK")
            }
        }
    }
    
    @IBAction func buttonVoltar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


extension EfetivacaoViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellConta"){
            cell.textLabel?.text = saldo ?? ""
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return efetivacaoController.titleForHeaderInSection(section: section)

    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return efetivacaoController.titleForFooterInSection(section: section)
    }
}
