//
//  PersistenceManager.swift
//  DrinkWater
//
//  Created by David Laiymani on 29/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//


import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let profile = "profile"
    }
    
    
    
    static func updateWith(profile: User, completed: @escaping (DWErrors?) -> Void) {
        retreiveProfile { (result) in
            switch result {
            case .success(let existingProfile):
                
                guard let existingProfile = existingProfile else {
                    print("Profile does not already exist -> add new one")
                    completed(save(profile: profile)) // profile does not exist -> add
                    return
                }
                
                // profile alredy exists -> update
                print("Profile already exist -> update: \(existingProfile.nbOfNotifs)")
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retreiveProfile(completed: @escaping (Result<User?, DWErrors>) -> Void) {
        guard let profileData = defaults.object(forKey: Keys.profile) as? Data else {
            completed(.success(nil))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let profile = try decoder.decode(User.self, from: profileData)
            completed(.success(profile))
        } catch {
            completed(.failure(.unableToGetProfile))
        }
    }
    
    
    static func save(profile: User) -> DWErrors? {
        do {
            let encoder = JSONEncoder()
            let encodedProfile = try encoder.encode(profile)
            defaults.set(encodedProfile, forKey: Keys.profile)
            return nil
        } catch {
            return .unableToSaveProfile
        }
    }
    
    
   // static func updateWith(profile: User, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
    //        retreiveProfile { (result) in
    //            switch result {
    //            case .success(let profil):
    //                var retreivedProfil = profil
    //                switch actionType {
    //                case .add:
    //                    guard !retreivedProfil.contains(profil) else {
    //                        completed(.alreadyInFavorites)
    //                        return
    //                    }
    //                    retreivedProfil.append(favorite)
    //
    //                case .remove:
    //                    retreivedFavorites.removeAll { $0.login == favorite.login }
    //                }
    //
    //                completed(save(favorites: retreivedFavorites))
    //
    //            case .failure(let error):
    //                completed(error)
    //            }
    //        }
    //    }
    
}
