//
//  NetworkFetching.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation

protocol NetworkFetching {
    func execute(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkFetching {
    func execute(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request, completionHandler: callback)
            .resume()
    }
}
