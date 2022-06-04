//
//  CharactersAPI.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation

protocol CharactersServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<Response, NetworkError>) -> Void)
}

class CharacterFetcher: CharactersServiceProtocol {
    let networkFetching: NetworkFetching
    init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }

    func fetchCharacters(completion: @escaping (Result<Response, NetworkError>) -> Void) {
        let url = URL.getCharacterURL()
        let request = URLRequest(url: url)
        return networkFetching.execute(request: request) { data, _, error in
            if let error = error {
                // cocoa error (network failure, etc.)
                completion(.failure(.underlying(error)))
                return
            }
            guard let data = data else {
                // empty data
                completion(.failure(.unknownResponse))
                return
            }
            do {
                let model = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(model))
            } catch {
                // failed to decode response
                completion(.failure(.decodingError))
            }
        }
    }
}

enum NetworkError: Error {
    case underlying(Error), unknownResponse, decodingError
    func description() -> String {
        switch self {
        case let .underlying(error): return error.localizedDescription
        case .unknownResponse: return "Bad response"
        case .decodingError: return "JSON decoding error"
        }
    }
}
