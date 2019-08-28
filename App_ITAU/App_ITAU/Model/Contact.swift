//
//  Contact.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 26/08/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class ContactRequest: Codable{
    
    let contato: [Contact]
    
    
}

class Contact: Codable{
    
    let name: String
    
    
}
