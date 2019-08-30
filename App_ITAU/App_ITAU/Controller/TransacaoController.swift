//
//  TransacaoController.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 27/08/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class TransacaoController{
    
    let jasonserializer = JsonSerializer()
    var saldoCC: Double = 0
    var saldoPoupanca: Double = 0
    
    // MARK: - Cria quantidade de linhas da tableView Contacts
    func numberOfrowsContact()->Int{
        
        return jasonserializer.serealizationJson().count
    }
    
    
    // MARK: - Retorna a primeira letra de cada nome, dentro de um Array
    func firstLetterContact() -> [String]{
        
        var firstLetterArray: [String] = []
        
          for firstLetter in jasonserializer.serealizationJson(){
            
          //  firstLetterArray = jasonserializer.serealizationJson().filter({$0.name.prefix(1)})
            
            firstLetterArray.append(String(firstLetter.name.prefix(1)))
            
        }
        print(firstLetterArray)
        return firstLetterArray
        
    }
    
    // MARK: - Retorna apenas uma letra inicial de cada nome, ou seja, numberOfSections
    func removeDuplicates() -> [String]{
        
        let uniqueItems = NSOrderedSet(array: firstLetterContact())
        print(uniqueItems)
        
        return uniqueItems.array as? [String] ?? []
    }
    
    
    // MARK: - Filtra os nomes dos contatos em cada seção
    func filterNamesforSection(section: Int) -> [Contact]{
        
        var namesForSection: [Contact] = []
        
        for _section in 0...removeDuplicates().count{
            
            if _section == section{
                
                namesForSection = jasonserializer.serealizationJson().filter({$0.name.prefix(1) == removeDuplicates()[_section]})
 
            }
        }
        return namesForSection
    }
    
    // MARK: - Coleta o nome do contato
    func contactName(contact: Contact) -> String{
        
        var label: String = ""
        
        label = contact.name
        
        return label
    }
    
    
}
