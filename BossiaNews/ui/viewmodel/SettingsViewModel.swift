//
//  ProfileViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 7.01.2024.
//

import Foundation

class SettingsViewModel {
    var nrepo = NewsRepo()
    func signOut(completion: @escaping (Bool) -> Void) {
        nrepo.signOut { success in
            completion(success)
        }
    }
}
