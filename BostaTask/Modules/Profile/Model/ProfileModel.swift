//
//  ProfileModel.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation

// MARK: - UsersResponseElement
struct UsersResponseElement: Codable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}

struct Albums: Codable {
    var userID, id: Int?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias UsersResponse = [UsersResponseElement]
typealias AlbumsResponse = [Albums]
