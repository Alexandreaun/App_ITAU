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
    let jasonserializer = JsonSerializer()
    let saldo = Saldo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      self.tableviewContas.delegate = self
      self.tableviewContas.dataSource = self
      self.tableviewContact.delegate = self
      self.tableviewContact.dataSource = self
        
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
        
        var cell = UITableViewCell()
        
        if tableView == tableviewContact{
        
        let cellContact = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let filterNamesSection = transacaocontroller.filterNamesforSection(section: indexPath.section)
        cellContact.textLabel?.text = transacaocontroller.contactName(contact: filterNamesSection[indexPath.row])
        
        cell = cellContact
            
        } else if tableView == tableviewContas{
         let cellContas = tableView.dequeueReusableCell(withIdentifier: "ContasCell", for: indexPath)
            
            if indexPath.row == 0{
                cellContas.textLabel?.text = "Conta Corrente: R$ \(saldo.saldoCC)"
               cellContas.accessoryType = .none
            } else if indexPath.row == 1{
                cellContas.textLabel?.text = "Conta Poupança: R$ \(saldo.saldoPOUPANCA)"
              cellContas.accessoryType = .checkmark

            }
            
        cell = cellContas
         
        }
        
        return cell
        
    }
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var saldos: Double
        let cell: UITableViewCell = UITableViewCell()
        
        if tableView == tableviewContas{

            if indexPath.row == 0{
                saldos = saldo.saldoCC
             //   cell.accessoryType = .checkmark
            }else if indexPath.row == 1{
                saldos = saldo.saldoPOUPANCA
            //    cell.accessoryType = .checkmark
            }
        }else if tableView == tableviewContact{
            
            
            
            
        }

    }
    
    
    
    
}
    

    
    
    


