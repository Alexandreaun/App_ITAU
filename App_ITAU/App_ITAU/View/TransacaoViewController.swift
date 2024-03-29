//
//  ViewController.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 26/08/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class TransacaoViewController: UIViewController {
    
    @IBOutlet weak var tableviewContas: UITableView!
    @IBOutlet weak var tableviewContact: UITableView!
    
    
    let transacaocontroller = TransacaoController()

    let saldoModel: Saldo = Saldo()
    let efetivacaoViewController = EfetivacaoViewController()
    var saldoSelecionado: Double = 0.0
    var indexContaSelecionada: Int = 0
    var saldoConvertString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SaldoShared.shared.arraySaldos = [saldoModel.saldoCC, saldoModel.saldoPOUPANCA]
        setupTableView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableviewContas.reloadData()
    }
    
    func setupTableView() {
        self.tableviewContas.delegate = self
        self.tableviewContas.dataSource = self
        self.tableviewContact.delegate = self
        self.tableviewContact.dataSource = self
    }
    
    func loadData() {
        transacaocontroller.getJsonSerializer { (error) in
            if let error = error {
                self.showError(error: error, buttonLabel: "Ok")
            } else {
                self.tableviewContact.reloadData()
            }
        }
    }
}

extension TransacaoViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numberOfSections: Int = 0
        
        if tableView == tableviewContact{
            numberOfSections = transacaocontroller.removeDuplicates().count
        }else if tableView == tableviewContas{
            numberOfSections = 1
        }
        
        return numberOfSections
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var titleForHeaderInSection: String = ""
        
        if tableView == tableviewContact{
            
            titleForHeaderInSection = transacaocontroller.titleForHeaderInSection(section: section)
            
        }else if tableView == tableviewContas{
            
            if section == 0{
                titleForHeaderInSection = "De:"
            }
        }
        return titleForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var titleForFooterInSection: String = ""
        
        if tableView == tableviewContas{
            
            if section == 0{
                titleForFooterInSection = "Para:"
            }
        }
        return titleForFooterInSection
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRowsInSection: Int = 0
        
        if tableView == tableviewContact{
            
            numberOfRowsInSection = transacaocontroller.numberOfRowsInSection(section: section)
            
        } else if tableView == tableviewContas{
            numberOfRowsInSection = 2
        }
        
        return numberOfRowsInSection
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        saldoSelecionado = SaldoShared.shared.arraySaldos[0]
        indexContaSelecionada = 0
        
        let formaterValue = String(format: "%.2f", saldoSelecionado)

        saldoConvertString = "Conta Corrente: R$ \(formaterValue)"
        
        var cell = UITableViewCell()
        
        if tableView == tableviewContact{
            
            let cellContact = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
            let filterNamesSection = transacaocontroller.filterNamesforSection(section: indexPath.section)

            cellContact.textLabel?.text = transacaocontroller.contactName(contact: filterNamesSection[indexPath.row])
            
            cell = cellContact
            
        } else if tableView == tableviewContas{
            let cellContas = tableView.dequeueReusableCell(withIdentifier: "ContasCell", for: indexPath)
            
            if indexPath.row == 0{
                let formaterValue = String(format: "%.2f", SaldoShared.shared.arraySaldos[0])
                
                cellContas.textLabel?.text = "Conta Corrente: R$ \(formaterValue)"
                cellContas.accessoryType = .checkmark
                
            } else if indexPath.row == 1{
                 let formaterValue = String(format: "%.2f", SaldoShared.shared.arraySaldos[1])
                
                cellContas.textLabel?.text = "Conta Poupança: R$ \(formaterValue)"
                cellContas.accessoryType = .none
            }
            
            cell = cellContas
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableviewContas{
            
            if let cell = tableviewContas.cellForRow(at: indexPath){
                
                if indexPath.row == 0{

                    saldoSelecionado = SaldoShared.shared.arraySaldos[0]

                    let formaterValue = String(format: "%.2f", saldoSelecionado)

                    indexContaSelecionada = indexPath.row
                    saldoConvertString = "Conta Corrente: R$ \(formaterValue)"
                    
                    cell.accessoryType = .checkmark
                    if let cell1 = tableviewContas.cellForRow(at: IndexPath(row: 1, section:0)){
                        cell1.accessoryType = .none
                    }
                }else if indexPath.row == 1{
                    saldoSelecionado = SaldoShared.shared.arraySaldos[1]
                    let formaterValue = String(format: "%.2f", saldoSelecionado)

                    saldoConvertString = "Conta Poupança: R$ \(formaterValue)"
                    
                    indexContaSelecionada = indexPath.row

                    cell.accessoryType = .checkmark
                    if let cell1 = tableviewContas.cellForRow(at: IndexPath(row: 0, section:0)){
                        cell1.accessoryType = .none
                    }
                }
                
            }
        }else{
            
            let filterNamesSection = transacaocontroller.filterNamesforSection(section: indexPath.section)
            
            let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "EfetivacaoViewController") as! EfetivacaoViewController

            viewcontroller.name = transacaocontroller.contactName(contact: filterNamesSection[indexPath.row])
            viewcontroller.agencia = transacaocontroller.contactAgencia(contact: filterNamesSection[indexPath.row])
            viewcontroller.conta = transacaocontroller.contactConta(contact: filterNamesSection[indexPath.row])
            
            viewcontroller.saldo = saldoConvertString
            viewcontroller.saldoContaSelecionada = saldoSelecionado
            viewcontroller.indexContaSelecionada = indexContaSelecionada
            
            present(viewcontroller, animated: true, completion: nil)
        }
    }
}
