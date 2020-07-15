//
//  TabBarController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 13/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var dataImage: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            
            if let motifSayaNavigationController = viewController as? MotifSayaNavigationViewController {
                
                if let motifSayaController = motifSayaNavigationController.viewControllers.first as? MotifSayaController {
                    motifSayaController.dataImage = dataImage
                }
            }
        }
    }
}
