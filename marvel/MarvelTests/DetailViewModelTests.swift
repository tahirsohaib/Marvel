//
//  DetailViewModelTests.swift
//  marvelTests
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import XCTest
@testable import marvel

class DetailViewModelTests: XCTestCase {
  var character: CharacterModel?
  var squadService: SquadFetcherUseCase?
  var viewModel: DetailViewModel?

  override func setUp() {
    character = CharacterModel(character: .init(id: 1, name: "Spiderman", description: "", thumbnail: .init(path: "www.example.com/image1", ext: "jpg")))
    squadService =  SquadServiceStab()
    viewModel = DetailViewModel(squadService: squadService!, character: character!)
  }

  func testDetailViewModelInitialzedCorrectly() throws {
    let isSquadMember = try XCTUnwrap(viewModel?.isSquadMember)
    XCTAssertTrue(isSquadMember)
  }

  func testRecruit() throws {
    let viewModel = try XCTUnwrap(viewModel)
    viewModel.recruit()
    XCTAssertTrue(viewModel.isSquadMember)
  }

  func testFire() throws {
    let viewModel = try XCTUnwrap(viewModel)
    viewModel.fire()
    XCTAssertFalse(viewModel.isSquadMember)
  }

  override func tearDown() {
    character = nil
    squadService = nil
    viewModel = nil
  }

}

class SquadServiceStab: SquadFetcherUseCase {
    func getAllSquadCharacterIds() -> [Int] {
        return [1, 2]
    }

    func recruit(_by id: Int) {
    }

    func fire(_by id: Int) {
    }

    func isSquadMember(id: Int) -> Bool {
        return getAllSquadCharacterIds().contains(id)
    }
}
