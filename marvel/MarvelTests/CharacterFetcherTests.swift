//
//  CharacterFetcherTests.swift
//  marvelTests
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import XCTest
@testable import marvel

class CharacterFetcherTests: XCTestCase {
    func testOnRequestSuccess() throws {
        let json = """
      {
      "data" : {
      "results" : [
         {
          "id": 1,
          "name": "Character One",
          "description": "Character one description.",
          "thumbnail": {
           "path": "",
          "extension": ""
      }
         }
      ]
      }
      }
      """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let characterFetcher = CharacterFetcher(networkFetching: NetworkFetchingStub(result: (data, nil, nil)))
        let expectation = XCTestExpectation(description: "Publishes decoded Response")

        characterFetcher.fetchCharacters { result in
            switch result {
            case .success(let res):
                XCTAssertEqual(res.data.results.count, 1)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected to succeed but failed with: \(error.description())")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testOnRequestFailure() throws {
        let json = """
      {
      "data" : {
      "results" : [
         {
          "id": 1,
          "name": "Character One",
          "description": "Character one description.",
          "thumbnail": {
           "path": "",
          "extension": ""
      }
         }
      ]
      }
      }
      """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let expectedError = URLError(.badServerResponse)
        let characterFetcher = CharacterFetcher(networkFetching: NetworkFetchingStub(result: (data, nil, expectedError)))
        let expectation = XCTestExpectation(description: "Publishes received error")

        characterFetcher.fetchCharacters { result in
            switch result {
            case .success(let res):
                XCTFail("It should not reach this point")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.description(), expectedError.localizedDescription)

                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    class NetworkFetchingStub: NetworkFetching {
        var result: (Data, URLResponse?, Error?)
        init(result: (Data, URLResponse?, Error?)) {
            self.result = result
        }
        func execute(request: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
            callback(result.0, result.1, result.2)
        }
    }
}
