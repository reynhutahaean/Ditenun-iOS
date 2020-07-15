//
//  GenKristikController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 07/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class GenKristikController: UIViewController {
    
    @IBOutlet weak var kristikImage: UIImageView!
    
    var kristikImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kristikImage.image = kristikImg
        
    }

    @IBAction func saveBtn(_ sender: Any) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController
//
//        vc?.dataImage = [kristikImg]
//
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let mainTabvc = segue.destination as? TabBarController {
            mainTabvc.dataImage = [kristikImg]
        }
    }
}
