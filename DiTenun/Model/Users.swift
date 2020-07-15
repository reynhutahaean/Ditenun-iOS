//
//  Users.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct Users : Decodable {
    let error: Bool
    let message: String
    let data: [User]
}

struct User : Decodable {
    let id: Int
    let name: String
    let email: String
    let alamat: String
    let jenis_tenun: String
    let no_hp: String
}
