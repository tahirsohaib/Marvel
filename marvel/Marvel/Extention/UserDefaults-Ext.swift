import Foundation

extension UserDefaults {
    static func saveCharacterId(id: Int) {
        let encoder = JSONEncoder()
        var ids = UserDefaults.getAllSquadCharacterIds()
        ids.append(id)

        if let encoded = try? encoder.encode(ids) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaultsKeys.squad)
        }
    }

    static func removeCharacterId(id: Int) {
        let encoder = JSONEncoder()
        var ids = UserDefaults.getAllSquadCharacterIds()
        if let index = ids.firstIndex(of: id) {
            ids.remove(at: index)
            if let encoded = try? encoder.encode(ids) {
                UserDefaults.standard.set(encoded, forKey: Constants.UserDefaultsKeys.squad)
            }
        }
    }

    static func getAllSquadCharacterIds() -> [Int] {
        if let squad = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.squad) as? Data {
            let decoder = JSONDecoder()
            if let ids = try? decoder.decode([Int].self, from: squad) {
                return ids
            }
        }
        return []
    }
}
