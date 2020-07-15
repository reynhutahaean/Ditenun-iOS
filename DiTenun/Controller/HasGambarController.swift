//
//  HasGambarController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 01/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

typealias Parameters = [String: String]

class HasGambarController: UIViewController {

    @IBOutlet weak var hasView: UIImageView!
    
    @IBOutlet weak var genMotifButton: UIButton!
    @IBOutlet weak var genKristikButton: UIButton!
    
    var hasImg = ""
    var titleView = ""
    var id_Motif = 0
    var GenMotif: [DataGenerate]?
    var listGenMotif: [MotifTenun]?

    var aView: UIView?
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titleView
        genMotifButton.layer.cornerRadius = 10
        genKristikButton.layer.cornerRadius = 10
        
        let baseUrl = APIModule.Endpoint
        
        if let imageURL = NSURL(string: baseUrl + hasImg.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) {
            if let data = NSData(contentsOf: imageURL as URL) {
                if let image = UIImage(data: data as Data) {
                    hasView.image = image
                }
            }
        }
    }
    
    @IBAction func generateMotif(_ sender: Any) {
        //fetchMotif()

        let vc = storyboard?.instantiateViewController(withIdentifier: "GenMotifController") as? GenMotifController

        self.showSpinner()
        
        let parameters = ["matrix": "2",
                          "color": "1"]
        
        let baseUrl = APIModule.Endpoint
        let imageURL = NSURL(string: baseUrl + hasImg.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let data = NSData(contentsOf: imageURL! as URL)
        let image = UIImage(data: data! as Data)
        
        guard let mediaImage = Media(withImage: image! , forKey: "img_file") else { return }
        
        guard let url = URL(string: "http://mobile.ditenun.com/api/motif") else { return }
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
                        let data = try NSData(data: data)
                        vc?.genData = data
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } catch {
                        print(error)
                    }
                }
            }
            }.resume()
    }
    
    func setListMotifTen(_ listMotif: [DataGenerate]) {
        GenMotif = listMotif.filter { $0.idMotif == id_Motif }
    }
    
    
    @IBAction func generateKristik(_ sender: Any) {
   
        let vc = storyboard?.instantiateViewController(withIdentifier: "SetupKristikViewController") as? SetupKristikViewController
        vc?.img = hasImg
        
        self.navigationController?.pushViewController(vc!, animated: true)
//        self.showSpinner()
//        if kecilButton.isSelected {
//            ukuranRadioButton(kecilButton)
//            let squareSize = "2"
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
    
    func formRequest(squareSize: String) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "GenKristikController") as? GenKristikController
        let parameters = ["square_size": squareSize,
                          "color_amount": "5"]
        
        let baseUrl = APIModule.Endpoint
        let imageURL = NSURL(string: baseUrl + hasImg.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
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
                        self.navigationController?.pushViewController(vc!, animated: true)
                    } catch {
                        print(error)
                    }
                }
            }
            }.resume()
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
                self.setListMotifTen(motif.data)
                //self.GenMotif = motif.data
                //print(motif.data)
                //print(self.setListMotifTen(motif.data))
            } catch let jsonErr {
                print("Error", jsonErr)
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

extension Data {

    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
