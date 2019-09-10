//
//  SaldoShared.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 09/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class SaldoShared{
    
    static let shared: SaldoShared = SaldoShared()
    
    var arraySaldos: [Double]
    
    
     init() {
        self.arraySaldos = []
        
    }
    
}
