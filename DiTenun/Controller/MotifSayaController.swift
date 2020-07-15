//
//  MotifSayaController.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class MotifSayaController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var motifView: UIView!
    //@IBOutlet weak var kristikView: UIView!
    //@IBOutlet weak var gambarView: UIView!
    
    var imagePicker = UIImagePickerController()
    
    var dataImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavbarImage()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imagePicker.delegate = self
        
    }
    
    func addNavbarImage() {
        
        var navController = navigationController!
        
        let image = #imageLiteral(resourceName: "Logo")
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
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
    
   /* @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            motifView.alpha = 1
            kristikView.alpha = 0
            gambarView.alpha = 0
        } else if sender.selectedSegmentIndex == 1{
            motifView.alpha = 0
            kristikView.alpha = 1
            gambarView.alpha = 0
        } else {
            motifView.alpha = 0
            kristikView.alpha = 0
            gambarView.alpha = 1
        }
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dataImage.append(image)
        picker.dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sayaCell", for: indexPath) as! MotifSayaCollectionViewCell
        
        cell.setImg(image: self.dataImage[indexPath.row])
        
        return cell
    }
}
