//
//  EfetivacaoViewController.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 04/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class EfetivacaoViewController: UIViewController {

    @IBOutlet weak var tableviewConta: UITableView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var name: String?
    var saldo: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableviewConta.dataSource = self
        
        if let name = name{
            contactNameLabel.text = name
        }
        
        if let saldo = saldo{
            valueLabel.text = String(saldo)
        }

        
    }
    
    
    
    
    @IBAction func buttonOne(_ sender: UIButton) {
        
   
    }
    
    
    @IBAction func buttonFive(_ sender: UIButton) {
    }
    
    
    
    @IBAction func buttonTen(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
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
            cell.textLabel?.text = String(saldo ?? 0)
            return cell
        }else{
            return UITableViewCell()
        }
       
      
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title: String = ""
        
        if section == 0{
            title = "De:"
        }
        
        return title
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        var title: String = ""
        
        if section == 0{
            title = "Para:"
        }
        
        return title
    }
    
    
    
    
    
    
    
    
    
}
