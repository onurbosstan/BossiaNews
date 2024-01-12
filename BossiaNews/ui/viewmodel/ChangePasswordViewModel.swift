//
//  ChangePasswordViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 13.01.2024.
//

import Foundation

class ChangePasswordViewModel {
    var nrepo = NewsRepo()
    
    func changePassword(newPassword: String, completion: @escaping (Error?) -> Void) {
            nrepo.changePassword(newPassword: newPassword) { error in
                completion(error)
            }
        }
}
