//
//  ErrorResponse.swift
//  DiTenun
//
//  Created by Reynaldo Cristinus Hutahaean on 11/07/20.
//  Copyright © 2020 Reynaldo Cristinus Hutahaean. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable, LocalizedError {
    let message: String
    var errorDescription: String? { return message }
}
