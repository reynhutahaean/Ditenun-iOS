//
//  AlertService.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: "Username atau Password salah", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
    
    func empty(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
    
    func alertRegister(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: "Lengkapi Form yang tersedia", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
}
