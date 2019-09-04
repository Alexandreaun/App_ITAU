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
    
    
    // MARK: - Retorna a primeira letra de cada nome, dentro de um Array, referente aos Contatos
    func firstLetterContact() -> [String]{
        
        var firstLetterArray: [String] = []
        
          for firstLetter in jasonserializer.serealizationJson(){
            
          //  firstLetterArray = jasonserializer.serealizationJson().filter({$0.name.prefix(1)})
            
            firstLetterArray.append(String(firstLetter.name.prefix(1)))
            
        }

        return firstLetterArray
        
    }
    
    // MARK: - Retorna apenas uma letra inicial de cada nome em ordem alfabetica dos Contatos
    func removeDuplicates() -> [String]{
        
        var unique: [String] = []
        
        let uniqueItems = NSOrderedSet(array: firstLetterContact())
        print(uniqueItems)
        
        unique = uniqueItems.array as? [String] ?? []
    
        return unique.sorted(by: { $0 < $1 })
        
       
    }
    
    // MARK: - Retorna a quantidade de linhas por seção da TableView Contatos
    func numberOfRowsInSection(section: Int) -> Int{
        
        var numberSection: Int = 0
        
        for _section in 0...removeDuplicates().count{
            
            if section == _section{
                
                numberSection = jasonserializer.serealizationJson().filter({$0.name.prefix(1) == removeDuplicates()[_section]}).count
                
            }
            
        }
        
        return numberSection
        
    }
    
    // MARK: - Retorna o título de cada seção TableView Contatos
    func titleForHeaderInSection(section: Int) -> String{
        
        var titleSection: String = ""
        
        for _section in 0...removeDuplicates().count{
            
            if section == _section{
                
                titleSection = removeDuplicates()[_section]
                
            }
            
        }
        
        return titleSection
        
        
        
    }
    
    
    
    // MARK: - Filtra e retorna os nomes dos Contatos em cada seção
    func filterNamesforSection(section: Int) -> [Contact]{
        
        var namesForSection: [Contact] = []
        
        for _section in 0...removeDuplicates().count{
            
            if _section == section{
                
                namesForSection = jasonserializer.serealizationJson().filter({$0.name.prefix(1) == removeDuplicates()[_section]})
 
            }
        }
        return namesForSection
    }
    
    // MARK: - Coleta o nome do Contato
    func contactName(contact: Contact) -> String{
        
        var label: String = ""
        
        label = contact.name
        
        return label
    }
    
    
}
