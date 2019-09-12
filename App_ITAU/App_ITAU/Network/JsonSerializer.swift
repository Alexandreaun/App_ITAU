//
//  JsonSerializer.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 26/08/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class JsonSerializer{
    
    func serealizationJson(completion: (ValidationError?, [Contact]) -> Void) {
        
        if let path = Bundle.main.path(forResource: "itau", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                do{
                    let result = try JSONDecoder().decode(ContactRequest.self, from: data)
                        completion(nil, result.contato)
                    
                }
            }catch{
                let error = ValidationError(titleError: "Atenção", messageError: "Não foi possivel carregar a lista de contatos.")
                completion(error, [])
            }
        }
    }

}
