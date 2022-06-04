//
//  CharactersAPI.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation
struct Response: Decodable {
    let data: ResultData
}

struct ResultData: Decodable {
    let results: [Character]
}
