//
//  MotifSayaCollectionViewCell.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import UIKit

class MotifSayaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var motifSayaImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setImg(image: UIImage) {
        self.motifSayaImg.image = image
    }
}
