//
//  Doc.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import Foundation

struct Doc: Codable {
    var key: String?
    var title, titleSort: String?
    var ratings_average: Double?
    var ratings_count: Int?
    var author_name: [String]?
    var cover_i: Int?
    
    var authorName: String?
    mutating func getAuthorName() {
        authorName = author_name?.first
    }
}
