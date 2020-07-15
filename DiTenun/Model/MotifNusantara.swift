//
//  MotifNusantara.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 04/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct MotifNusantara : Decodable {
    let error: Bool
    let message: String
    let data: [Datas]
}

struct Datas : Decodable {
    
    var id_tenun: Int
    let nama_tenun: String
    let deskripsi_tenun : String
    let sejarah_tenun: String?
    let kegunaan_tenun: String
    let warna_dominan: String?
    let asal_tenun: String
    let img_src: String
    let nama_motif: String
    
}



