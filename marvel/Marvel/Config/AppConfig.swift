//
//  AppDelegate.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation

class AppConfig {
    enum Key: String {
        case baseApiUrl = "BASE_API_URL"
        case apiPath = "API_PATH"
        case publicKey = "API_KEY_PUBLIC"
        case privateKey = "API_KEY_PRIVATE"
    }

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: Key) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            fatalError("Missing env key")
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            fatalError("Wrong type for env key")
        }
    }

    static let ts = 1

    static var hash: String {
        let combined = "\(ts)" + value(for: .privateKey) + value(for: .publicKey)
        let md5Data = MD5Generator().MD5(string: combined)
        let md5Hex = md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
}
