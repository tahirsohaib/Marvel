//
//  CharacterModelTest.swift
//  marvelTests
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import XCTest
@testable import marvel

class CharacterModelTest: XCTestCase {
  func testViewModelMapValues() {
    let character = Character(id: 1, name: "Spiderman", description: "", thumbnail: .init(path: "www.example.com/image1", ext: "jpg"))
      let viewModel = CharacterModel(character: character)
      XCTAssertEqual(viewModel.name, character.name)
      XCTAssertEqual(viewModel.biography, character.description)
      XCTAssertEqual(viewModel.imageUrl, "www.example.com/image1.jpg")
  }
}
