//
//  EfetivacaoController.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 05/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class EfetivacaoController{
    
    let saldoModel: Saldo = Saldo()
    
    func titleForHeaderInSection(section: Int) -> String{
        var title: String = ""
        
        if section == 0{
            title = "De:"
        }
        
        return title
        
    }
    
    func titleForFooterInSection(section: Int) -> String{
        
        var title: String = ""
        
        if section == 0{
            title = "Para:"
        }
        
        return title
    }
}
