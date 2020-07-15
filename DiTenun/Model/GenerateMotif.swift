//
//  GenerateMotif.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 02/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct GenerateMotif : Decodable {
    let error: Bool
    let message: String
    let data: [DataGenerate]
}

struct DataGenerate : Decodable {
    let id: Int
    let idMotif: Int?
    let sourceFile: String?
    let generateFile: String
    let nama_generate: String
}
