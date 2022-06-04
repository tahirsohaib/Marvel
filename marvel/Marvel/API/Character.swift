//
//  CharactersAPI.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let ext: String

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
