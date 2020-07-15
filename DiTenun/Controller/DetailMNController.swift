//
//  DetailMNController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 01/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class DetailMNController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var detailImagee: UIImageView!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var collectionsView: UICollectionView!
    
    var idTenun = 0
    var detailTtl = ""
    var detailImg = ""
    var originalLbl = ""
    var overview = ""
    var colorLbl = ""
    var purposeLbl = ""
    
    var listMotifTen: [DataMotif]?
    
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 30) / 4
        //let height = (view.frame.size.height - 10) / 4
        let layout = collectionsView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 90, height: 80)
        
        view.addSubview(scrollView)
        
        let baseUrl = APIModule.Endpoint
        
        if let imageURL = NSURL(string: baseUrl + detailImg) {
            if let data = NSData(contentsOf: imageURL as URL) {
                if let image = UIImage(data: data as Data) {
                    detailImagee.image = image
                }
            }
        }
        
        detailLabel.text = detailTtl
        originalLabel.text = originalLbl
        colorLabel.text = colorLbl
        purposeLabel.text = purposeLbl
        overviewLbl.text = overview
        
        collectionsView.delegate = self
        collectionsView.dataSource = self
        
        fetchMotif()
        
        print(idTenun)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listMotifTen?.filter{ $0.id_tenun == idTenun }.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DetailMotifCollectionViewCell
        
        /*if let countM = listMotifTen?.filter({$0.id_tenun == idTenun}) {
            for value in countM {
                newArr.append(value.nama_motif)
                newArr.append(value.img_src)
                print(newArr)
            }
        }*/

        //let countMotif = listMotifTen?.filter($0)

        /*for value in listMotifTen! {
            
            if value.id_tenun == idTenun {
                newArr.append(value())
                detailCell.motifLabel.text
            }
        }*/
        
        
        //detailCell.motifLabel.text = countMotif
        
        //print(countMotif)
        
        /*if let countMotif = listMotifTen?.filter ({ $0.id_tenun == idTenun }) {
            
            for i in countMotif {
                detailCell.motifLabel.text = i.nama_motif
                let motifImg = i.img_src
                let baseUrl = "http://mobile.ditenun.com/ModulTerbaru/api-tenun/"
                
                if let imageURL = NSURL(string: baseUrl + motifImg) {
                    if let data = NSData(contentsOf: imageURL as URL) {
                        if let image = UIImage(data: data as Data) {
                            detailCell.motifImage.image = image
                        }
                    }
                 }
            }
            
        }*/
    
        
//        if let listDataMotif = listMotifTen {
//            listDataMotif.filter { $0.id_tenun == idTenun }.compactMap{ dataMotif in
//
//                /*for i in countMotif {
//                 detailCell.motifLabel.text = i.nama_motif
//                 let motifImg = i.img_src
//                 }*/
//
//                detailCell.motifLabel.text = dataMotif.nama_motif
//                //print(detailCell.motifLabel.text)
//
//                let motifImg = dataMotif.img_src
//                let baseUrl = "http://mobile.ditenun.com/ModulTerbaru/api-tenun/"
//
//                if let imageURL = NSURL(string: baseUrl + motifImg) {
//                    if let data = NSData(contentsOf: imageURL as URL) {
//                        if let image = UIImage(data: data as Data) {
//                            detailCell.motifImage.image = image
//                        }
//                    }
//                }
//            }
//        }
        if let dataMotif = listMotifTen?[indexPath.row] {
        
            detailCell.motifLabel.text = dataMotif.nama_motif
            //print(detailCell.motifLabel.text)
            
            let baseUrl = "http://mobile.ditenun.com/ModulTerbaru/api-tenun/"
            
            if let motifImg = dataMotif.img_src.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed), let imageURL = NSURL(string: baseUrl + motifImg) {
                if let data = NSData(contentsOf: imageURL as URL) {
                    if let image = UIImage(data: data as Data) {
                        detailCell.motifImage.image = image
                    }
                }
            }
        }
        
        /*if idTen == idTenun {
            let namaTen = listMotifTen![indexPath.row].nama_motif
            detailCell.motifLabel.text = namaTen
            print(namaTen)
            
            if let imageURL = NSURL(string: baseUrl + motifImg) {
                if let data = NSData(contentsOf: imageURL as URL) {
                    if let image = UIImage(data: data as Data) {
                        detailCell.motifImage.image = image
                    }
                }
            }
        }*/

        //print(detailCell.motifLabel.text)
        //detailCell.motifLabel.text = namaTen
        return detailCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HasGambarController") as? HasGambarController

//        if let countMotif = listMotifTen?.first(where: { $0.id_tenun == idTenun }) {
//            vc?.hasImg = countMotif.img_src
//            vc?.titleView = countMotif.nama_motif
//            vc?.id_Motif = countMotif.id
//        }
        let motifNus = listMotifTen![indexPath.row]
        vc?.hasImg = motifNus.img_src
        vc?.titleView = motifNus.nama_motif
        vc?.id_Motif = motifNus.id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func fetchMotif() {
        
        let urlResource = "http://mobile.ditenun.com/api/motifTenun?size=all"
        
        guard let url = URL(string: urlResource) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let motif = try JSONDecoder().decode(MotifTenun.self, from: data)
                self.setListMotifTen(motif.data)
                //print(motifs.data)
            } catch let jsonErr {
                print("Error", jsonErr)
            }
            
            DispatchQueue.main.async {
                self.collectionsView.reloadData()
            }
            
            }.resume()
    }
    
    func setListMotifTen(_ listMotif: [DataMotif]) {
        listMotifTen = listMotif.filter { $0.id_tenun == idTenun }
    }
    
}
