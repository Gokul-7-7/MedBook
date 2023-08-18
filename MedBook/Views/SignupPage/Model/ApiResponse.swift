//
//  ApiResponse.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

struct ApiResponse: Decodable {
    var status: String?
    var statusCode: Int?
    var version, access: String?
    var data: [String: Country]?
}
