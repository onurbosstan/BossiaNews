//
//  RegisterViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 4.01.2024.
//

import Foundation

class RegisterViewModel {
    var nrepo = NewsRepo()
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void ) {
        nrepo.signUp(email: email, password: password) { result in
            completion(result)
        }
    }
}
