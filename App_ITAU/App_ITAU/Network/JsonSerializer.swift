//
//  JsonSerializer.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 26/08/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class JsonSerializer{
    
    func serealizationJson(){
        
        var arrayContacts: [Contact] = []
        
        if let path = Bundle.main.path(forResource: "itau", ofType: "json"){
            
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                do{
                    if let result = try JSONDecoder().decode(ContactRequest.self, from: data) as? ContactRequest{
                        for contacts in result.contato{
                            arrayContacts.append(contacts)
                        }
                    }
                }
            }catch{
                print("error")
            }
        }
    }

}
