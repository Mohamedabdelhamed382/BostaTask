//
//  Model.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation

// MARK: - PhotoAlbum
import Foundation

// MARK: - PhotoAlbum
struct PhotoAlbum: Codable {
    var albumID, id: Int?
    var title: String?
    var url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
