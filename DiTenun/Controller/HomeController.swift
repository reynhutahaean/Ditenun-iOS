//
//  ViewController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 04/03/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var account: UIBarButtonItem!
    //var motifs: [NSDictionary]?
    @IBOutlet var accountBtns: [UIButton]!
    var listMotifNus: [Datas]?
    var listMotif: [DataMotif]?
    
    let transparentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 20) / 3
        let height = (view.frame.size.height) / 6
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 100, height: 125)
        
        addNavbarImage()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        fetchData()
    }
    
    func addBtnBarImg() {
        
        let image = #imageLiteral(resourceName: "Image")
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        imageView.contentMode = .scaleAspectFit
        
        
    }
    
    func addNavbarImage() {
        
        let image = #imageLiteral(resourceName: "Logo")
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
        
        //logout.isHidden = true
    }
    
    func addTransparentView() {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { self.transparentView.alpha = 0.5 }, completion: nil)
    }
   
    @objc func removeTransparentView() {
        
    }
    
    @IBAction func accountButton(_ sender: UIButton) {
        //addTransparentView()
        accountBtns.forEach { (button) in
            button.isHidden = !button.isHidden
            button.layer.cornerRadius = 0.5
        }
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchViews(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            collectionView.isHidden = false
            secondView.isHidden = true
        case 1:
            collectionView.isHidden = true
            secondView.isHidden = false
        default:
            break
        }
        
    }
    
    /*@IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            collectionView.alpha = 1
            secondView.alpha = 0
        } else {
            collectionView.alpha = 0
            secondView.alpha = 1
        }
    }*/
    
    @IBAction func importTab(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(image, animated: true)
    }

    @IBAction func cameraTab(_ sender: Any) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(camera, animated: true)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInterItemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMotifNus?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! MotifCollectionViewCell
        
        let motifNus = listMotifNus![indexPath.row]
        let title = motifNus.nama_tenun
        let images = motifNus.img_src
        
        let baseUrl = APIModule.Endpoint
        
        if let imageURL = NSURL(string: baseUrl + images) {
            if let data = NSData(contentsOf: imageURL as URL) {
                if let image = UIImage(data: data as Data) {
                    cell.imageView.image = image
                    cell.imageView.layer.cornerRadius = 10
                    cell.imageView.clipsToBounds = true
                }
            }
        }
        
        cell.titleLabel.text = title
         print("row \(indexPath.row)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMNController") as? DetailMNController
        //let vc = storyboard?.instantiateInitialViewController() as? DetailMNController
        let motifNus = listMotifNus![indexPath.row]
        let idTen = listMotifNus![indexPath.row].id_tenun
        
        vc?.idTenun = idTen
        vc?.detailImg = motifNus.img_src
        vc?.detailTtl = motifNus.nama_tenun
        vc?.originalLbl = motifNus.asal_tenun
        vc?.colorLbl = motifNus.warna_dominan as! String
        vc?.purposeLbl = motifNus.kegunaan_tenun
        vc?.overview = motifNus.deskripsi_tenun
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    

    /* func fetchData() {
        let url = NSURL(string: "http://api.ditenun.com/api/tenun")
        let request = NSURLRequest(
            url: url! as URL,
            cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest,
                                                        completionHandler: { (dataOrNil, response, error) in
                                                            if let data = dataOrNil {
                                                                if let responseDictionary = try! JSONSerialization.jsonObject(
                                                                    with: data, options: []) as? NSDictionary {
                                                                    print("response: \(responseDictionary)")
                                                                    self.event = responseDictionary["data"] as! Event
                                                                    self.collectionView.reloadData()
                                                                }
                                                            }
        })
        task.resume()
    } */
    
    func fetchData () {
        
        let urlResource = APIModule.Endpoint
        let dataUrl = "tenun"
        
        guard let url = URL(string: urlResource + dataUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let motif = try JSONDecoder().decode(MotifNusantara.self, from: data)
                self.listMotifNus = motif.data
                //print(motifs.data)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }.resume()
    }
    
//    @IBAction func logoutBtn(_ sender: Any) {
//        
//        self.performSegue(withIdentifier: "hg", sender: self)
//    }
    
}
