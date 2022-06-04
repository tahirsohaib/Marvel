import Foundation

extension URL {
    static func getCharacterURL() -> URL {
        let apiUrl: String = AppConfig.value(for: .baseApiUrl)
        let apiPath: String = AppConfig.value(for: .apiPath)
        let url = apiUrl.appending(apiPath)
        let urlComponents = NSURLComponents(string: url)!
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: "\(AppConfig.ts)"),
            URLQueryItem(name: "apikey", value: AppConfig.value(for: .publicKey)),
            URLQueryItem(name: "hash", value: AppConfig.hash),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "30")
        ]
        return urlComponents.url!
    }
}
