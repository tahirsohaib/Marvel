import Foundation

typealias Characters = [CharacterModel]

struct CharacterModel {
    let id: Int
    let name: String
    let imageUrl: String
    let biography: String

    init(character: Character) {
        id = character.id
        name = character.name
        imageUrl = character.thumbnail.path + "." + character.thumbnail.ext
        biography = character.description
    }
}
