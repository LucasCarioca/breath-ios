//
// Created by Lucas Desouza on 8/23/20.
// Copyright (c) 2020 Lucas Desouza. All rights reserved.
//

import Foundation

struct Version: Codable {
    var version: String
    var isNew: Bool
    var description: String
    var newFeatures: [Change]
}

struct Change: Hashable, Codable {
    var title: String
    var description: String
    var image: String
}

class VersionController {

    private static let VERSION_KEY: String = "version"
    private static let CURRENT: String = "2.1.0"
    private static let DESCRIPTION: String = "We have made some updates to the app."
    private static let NEW_FEATURES: [Change] = [
        Change(title: "Enhanced pet profile", description: "We have been enhancing the pet profile. You can now save record your pets name, chip id, date of birth, and  personalize the target breathing rate.", image: "dog")
    ]

    public static func saveVersion(version: Version){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(version){
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: VERSION_KEY)
        }
    }

    public static func loadVersion() -> Version {
        let defaults = UserDefaults.standard
        if let version = defaults.object(forKey: VERSION_KEY) as? Data{
            let decoder = JSONDecoder()
            if let loadedVersion = try? decoder.decode(Version.self, from: version){
                if(loadedVersion.version == CURRENT) {
                    return loadedVersion
                }
            }
        }
        let newVersion = Version(version: CURRENT, isNew: true, description: DESCRIPTION, newFeatures: NEW_FEATURES)
        saveVersion(version: newVersion)
        return newVersion
    }

}
