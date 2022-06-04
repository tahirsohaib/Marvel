//
//  ListViewModelTest.swift
//  marvelTests
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import XCTest
@testable import marvel

class ListViewModelTest: XCTestCase {

  func testGetCharatersSuccess() throws {
      let resultData = ResultData(results: [Character(id: 1, name: "Test", description: "test description", thumbnail: .init(path: "", ext: ""))])
      let response = Response(data: resultData)
    let viewModel = ListViewModel(characterService: CharacterFetcherAPIStub(returning: .success(response)))
      viewModel.getCharacters()
      XCTAssertEqual(viewModel.characters.count, 1)
  }

  func testGetCharactersFailure() {
    let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error: Trying to parse Characters to model"])
      let viewModel = ListViewModel(characterService: CharacterFetcherAPIStub(returning: .failure(.underlying(error))))
      viewModel.getCharacters()
    XCTAssertEqual(viewModel.error, error.localizedDescription)
  }

}

// MARK: CHARACTER FETCHER STUB
class CharacterFetcherAPIStub: CharactersServiceProtocol {
    private let result: Result<Response, NetworkError>
    init(returning result: Result<Response, NetworkError>) {
        self.result = result
    }
    func fetchCharacters(completion: @escaping (Result<Response, NetworkError>) -> Void) {
        completion(result)
    }
}
