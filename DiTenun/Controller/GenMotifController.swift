//
//  GenMotifController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 02/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class GenMotifController: UIViewController {

    @IBOutlet weak var genImage: UIImageView!
    
    var genImg = ""
    var id = 0
    var genMotif: [DataGenerate]?
    var genData = NSData()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(data: genData as! Data)
        genImage.image = image
        
        //let gen = genMotif
        
//        let baseUrl = "http://mobile.ditenun.com/ModulTerbaru/api-tenun/"
//        
//        if let imageURL = NSURL(string: baseUrl + genImg) {
//            if let data = NSData(contentsOf: imageURL as URL) {
//                if let image = UIImage(data: data as Data) {
//                    genImage.image = image
//                }
//            }
//        }
        
        //fetchMotif()
        //print(genImg)
        //print(id)

    }

    func fetchMotif() {
        
        let urlResource = "http://mobile.ditenun.com/api/listGenerate"
        
        guard let url = URL(string: urlResource) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let motif = try JSONDecoder().decode(GenerateMotif.self, from: data)
                self.genMotif = motif.data
                //print(motif.data)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
            
            }.resume()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MotifSayaController") as? MotifSayaController
//        
//        let image = UIImage(data: genData as Data)
//        vc?.dataImage = [image] as! [UIImage]
//        
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainTabvc = segue.destination as? TabBarController {
            let image = UIImage(data: genData as! Data)
            mainTabvc.dataImage = [image] as! [UIImage]
        }
    }
}
