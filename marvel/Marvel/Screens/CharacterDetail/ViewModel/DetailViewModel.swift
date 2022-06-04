//
//  CharacterDetailViewModel.swift
//  marvel
//
//  Created by Sohaib Tahir on 03/06/2022.
//

import Foundation

class DetailViewModel {
    let character: CharacterModel
    var isSquadMember: Bool
    private let squadService: SquadFetcherUseCase

    init(squadService: SquadFetcherUseCase, character: CharacterModel) {
        self.squadService = squadService
        self.character = character
        isSquadMember = squadService.isSquadMember(id: character.id)
    }

    func recruit() {
        squadService.recruit(_by: character.id)
        isSquadMember = true
    }

    func fire() {
        squadService.fire(_by: character.id)
        isSquadMember = false
    }
}
