//
//  NetworkClient.swift
//  BostaTask
//
//  Created by MOHAMED ABD ELHAMED AHMED on 01/03/2023.
//

import Foundation
import Moya

enum NetworkClient: TargetType {
    case getUsers
    case getAlbums(userId: String)
    case getPhotos(albumId: String)
}

extension NetworkClient {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getAlbums:
            return "/albums"
        case .getPhotos:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsers, .getAlbums, .getPhotos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getAlbums(let userId):
            return .requestParameters(parameters: ["userId":userId], encoding: URLEncoding.default)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId":albumId], encoding: URLEncoding.default)
        
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUsers, .getAlbums, .getPhotos:
            return ["Accept":"application/json",
                    "Content-type":"application/json"]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getUsers, .getAlbums, .getPhotos:
            return "should be filled properly".utf8Encoded
        }
    }
    
    
}

private extension String {
    var utf8Encoded:Data {
        return data(using: .utf8)!
    }
}

