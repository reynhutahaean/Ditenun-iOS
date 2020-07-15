//
//  MotifTenun.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 08/05/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct MotifTenun : Decodable {
    let error: Bool
    let message: String
    let data: [DataMotif]
}

struct DataMotif : Decodable {
    let id: Int
    var id_tenun: Int
    let nama_motif: String
    let img_src: String
}
