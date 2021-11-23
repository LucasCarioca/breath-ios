//
//  PetProfile.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 8/18/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import Foundation

struct PetProfileDeprecated: Codable {
    var targetBpm: Int
}

struct PetProfile: Codable {
    var targetBpm: Int
    var name: String
    var chipId: String
}

class PetProfileController {

    private static let PET_PROFILE_KEY = "petprofile"
    private static let DEFAULT_TARGET_BPM = 30

    public static func savePetProfile(profile: PetProfile) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: PET_PROFILE_KEY)
        }
    }

    public static func loadPetProfile() -> PetProfile {
        let defaults = UserDefaults.standard
        if let profile = defaults.object(forKey: PET_PROFILE_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedPetProfile = try? decoder.decode(PetProfile.self, from: profile) {
                return loadedPetProfile
            } else {
                if let deprecatedProfile = try? decoder.decode(PetProfileDeprecated.self, from: profile) {
                    var newProfile = PetProfile(targetBpm: DEFAULT_TARGET_BPM, name: "MyPet", chipId: "")
                    newProfile.targetBpm = deprecatedProfile.targetBpm
                    savePetProfile(profile: newProfile)
                    return newProfile
                }
            }
        }
        let newProfile = PetProfile(targetBpm: DEFAULT_TARGET_BPM, name: "MyPet", chipId: "")
        savePetProfile(profile: newProfile)
        return newProfile
    }

    public static func resetDefaults() {
        let newProfile = PetProfile(targetBpm: DEFAULT_TARGET_BPM, name: "MyPet", chipId: "")
        savePetProfile(profile: newProfile)
    }
}
