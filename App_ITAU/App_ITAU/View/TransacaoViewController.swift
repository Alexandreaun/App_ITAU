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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     // self.tableviewContas.delegate = self
     // self.tableviewContas.dataSource = self
      self.tableviewContact.delegate = self
      self.tableviewContact.dataSource = self
        
    }
    
  
    
}



extension TransacaoViewController: UITableViewDelegate, UITableViewDataSource{

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return transacaocontroller.removeDuplicates().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var titleSection: String = ""
        
        for _section in 0...transacaocontroller.removeDuplicates().count{
            
            if section == _section{
                
                titleSection = transacaocontroller.removeDuplicates()[_section]
                
            }
            
        }
        
        return titleSection
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var numberSection: Int = 0
        
         for _section in 0...transacaocontroller.removeDuplicates().count{
        
            if section == _section{
                
                 numberSection = jasonserializer.serealizationJson().filter({$0.name.prefix(1) == transacaocontroller.removeDuplicates()[_section]}).count
                
            }
  
        }
 
             return numberSection

    }
        
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        
        let filterNamesSection = transacaocontroller.filterNamesforSection(section: indexPath.section)
        
        cell.textLabel?.text = transacaocontroller.contactName(contact: filterNamesSection[indexPath.row])
        
        return cell
            
        }
    
    
    
    
}
    
    
    
    
    


