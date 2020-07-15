//
//  SetupKristikViewController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 14/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class SetupKristikViewController: UIViewController {
    
    @IBOutlet weak var imgPreview: UIImageView!
    
    @IBOutlet weak var kecilButton: UIButton!
    @IBOutlet weak var sedangButton: UIButton!
    @IBOutlet weak var besarButton: UIButton!
    
    @IBOutlet weak var sedikitButton: UIButton!
    @IBOutlet weak var sedanggButton: UIButton!
    @IBOutlet weak var banyakButton: UIButton!
    
    @IBOutlet weak var generateButton: UIButton!
    
    var img = ""
    
    var aView: UIView?
    var checkedBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generateButton.isHidden = true
        generateButton.layer.cornerRadius = 10
        
        let baseUrl = APIModule.Endpoint
        
        if let imageURL = NSURL(string: baseUrl + img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) {
            if let data = NSData(contentsOf: imageURL as URL) {
                if let image = UIImage(data: data as Data) {
                    imgPreview.image = image
                }
            }
        }
    }
    
    @IBAction func ukuranRadioButton(_ sender: UIButton) {
        
        if sender.tag == 1 {
            kecilButton.isSelected = true
            sedangButton.isSelected = false
            besarButton.isSelected = false
        } else if sender.tag == 2 {
            kecilButton.isSelected = false
            sedangButton.isSelected = true
            besarButton.isSelected = false
        } else if sender.tag == 3 {
            kecilButton.isSelected = false
            sedangButton.isSelected = false
            besarButton.isSelected = true
        }
        
        //checkedButton()
    }
    
    @IBAction func warnaRadioButton(_ sender: UIButton) {
        
        if sender.tag == 4 {
            sedikitButton.isSelected = true
            sedanggButton.isSelected = false
            banyakButton.isSelected = false
        } else if sender.tag == 5 {
            sedikitButton.isSelected = false
            sedanggButton.isSelected = true
            banyakButton.isSelected = false
        } else if sender.tag == 6{
            sedikitButton.isSelected = false
            sedanggButton.isSelected = false
            banyakButton.isSelected = true
        }
        
        //checkedButton()
    }
    @IBAction func generateKristikBtn(_ sender: Any) {
        
        showSpinner()
//        if kecilButton.isSelected {
//            ukuranRadioButton(kecilButton)
//            let squareSize = "2"
//            //let colorAmount =
//            formRequest(squareSize: squareSize)
//            //self.performSegue(withIdentifier: "testSegue", sender: self)
//        } else if sedangButton.isSelected {
//            ukuranRadioButton(sedangButton)
//            let squareSize = "4"
//            formRequest(squareSize: squareSize)
//        } else {
//            ukuranRadioButton(besarButton)
//            let squareSize = "7"
//            formRequest(squareSize: squareSize)
//        }
        generateKristik()
    }
    
    func checkedButton() {
        
        if kristikSize().isEmpty && kristikColor().isEmpty {
            generateButton.isHidden = true
        } else {
            generateButton.isHidden = false
        }
    }
    
    func generateKristik() {
    
        //generateButton.isEnabled = true
        let squareSize = kristikSize()
        let colorAmount = kristikColor()
        
        formRequest(squareSize: squareSize, colorAmount: colorAmount)
    }
    
    func kristikSize() -> String {
        
        if kecilButton.isSelected {
            ukuranRadioButton(kecilButton)
            return "2"
        } else if sedangButton.isSelected {
            ukuranRadioButton(sedangButton)
            return "4"
        } else if besarButton.isSelected {
            ukuranRadioButton(besarButton)
            return "7"
        }

        return "4"
    }
    
    func kristikColor() -> String {
        
        if sedikitButton.isSelected {
            warnaRadioButton(sedikitButton)
            return "5"
        } else if sedanggButton.isSelected {
            warnaRadioButton(sedanggButton)
            return "15"
        } else if banyakButton.isSelected {
            warnaRadioButton(banyakButton)
            return "30"
        }
        
        return "5"
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)".data(using: .utf8)!)
                body.append("\(value + lineBreak)".data(using: .utf8)!)
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)".data(using: .utf8)!)
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)".data(using: .utf8)!)
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
        
        return body
    }
    
    func formRequest(squareSize: String, colorAmount: String) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "GenKristikController") as? GenKristikController
        let parameters = ["square_size": squareSize,
                          "color_amount": colorAmount]
        
        let baseUrl = APIModule.Endpoint
        let imageURL = NSURL(string: baseUrl + img.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let data = NSData(contentsOf: imageURL! as URL)
        let image = UIImage(data: data! as Data)
        
        guard let mediaImage = Media(withImage: image! , forKey: "img_file") else { return }
        
        guard let url = URL(string: "http://mobile.ditenun.com/api/kristiks") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Jt3nuN_20161130", forHTTPHeaderField: "Authorization")
        
        let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    
                    do {
                        self.removeSpinner()
                        let image = try UIImage(data: data)
                        vc?.kristikImg = image!
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } catch {
                        print(error)
                    }
                }
            }
            }.resume()
    }
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
