//
//  Register.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct Register : Decodable {
    let succes: Bool
    let message: String
    let data: [RegisterData]
}

struct RegisterData : Decodable {
    let name: String
    let email: String
    let no_hp: String
    let alamat: String
    let jenis_tenun: String
}
