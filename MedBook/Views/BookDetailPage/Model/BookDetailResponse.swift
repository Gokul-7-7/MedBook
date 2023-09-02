//
//  BookDetailResponse.swift
//  MedBook
//
//  Created by Gokul on 02/09/23.
//

import Foundation

struct BookDetailResponse: Codable {
    var description: String?
    var title: String?
    var firstPublishDate: String?
    var key: String?
}
