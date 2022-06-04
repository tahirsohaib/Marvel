//
//  CharacterListViewModel.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation

class ListViewModel: NSObject {
    var error: String?
    private var characterService: CharactersServiceProtocol
    private var squadFetcher: SquadFetcherUseCase
    var reloadTableView: (() -> Void)?
    var reloadSquadSection: (() -> Void)?
    var didUpdateSquad: (() -> Void)?
    var errorAlert: ((String) -> Void)?

    var characters = Characters() {
        didSet {
            reloadTableView?()
        }
    }

    var squad = Characters() {
        didSet {
            reloadTableView?()
        }
    }

    init(characterService: CharactersServiceProtocol = CharacterFetcher(), squadFetcher: SquadFetcherUseCase = SquadFetcher()) {
        self.characterService = characterService
        self.squadFetcher = squadFetcher
    }

    func loadSquad() {
        squad = characters
            .filter { squadFetcher.getAllSquadCharacterIds().contains($0.id) }
            .sorted(by: { $0.id < $1.id })
    }

    func getCharacters() {
        characterService.fetchCharacters { result in
            switch result {
            case let .success(res):
                self.fetchData(characters: res)
            case let .failure(error):
                self.error = error.description()
                self.errorAlert?(error.description())
            }
        }
    }

    func fetchData(characters: Response) {
        self.characters = characters.data.results.map { CharacterModel(character: $0) }.sorted { $0.name < $1.name }
        loadSquad()
    }

    func getCellCharacterModel(at indexPath: IndexPath) -> CharacterModel {
        return characters[indexPath.row]
    }

    func getSquadCharacterModel(at indexPath: IndexPath) -> CharacterModel {
        return squad[indexPath.row]
    }
}
