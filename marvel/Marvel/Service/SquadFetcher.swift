import Foundation

protocol SquadFetcherUseCase {
    func getAllSquadCharacterIds() -> [Int]
    func recruit(_by id: Int)
    func fire(_by id: Int)
    func isSquadMember(id: Int) -> Bool
}

class SquadFetcher: SquadFetcherUseCase {
    func getAllSquadCharacterIds() -> [Int] {
        return UserDefaults.getAllSquadCharacterIds()
    }

    func recruit(_by id: Int) {
        UserDefaults.saveCharacterId(id: id)
    }

    func fire(_by id: Int) {
        UserDefaults.removeCharacterId(id: id)
    }

    func isSquadMember(id: Int) -> Bool {
        return UserDefaults.getAllSquadCharacterIds().contains(id)
    }
}
