//
//  UIViewControllerExtension.swift
//  App_ITAU
//
//  Created by Alexandre Aun on 10/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

extension UIViewController{
    
    
    func showError(error: NSError, buttonLabel: String) {
        let alert: UIAlertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        let actionOk: UIAlertAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    func showErrorAction(error: NSError, buttonLabel: String, action:@escaping (() -> ())) {
      
        let alert: UIAlertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        
        let ac: UIAlertAction = UIAlertAction(title: buttonLabel, style: .default) { (act) in
            alert.dismiss(animated: true, completion: nil)
            action()
        }
        alert.addAction(ac)
        self.present(alert, animated: true, completion: nil)
    
    }
}
