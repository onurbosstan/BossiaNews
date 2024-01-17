//
//  LogInViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 3.01.2024.
//

import Foundation

class LogInViewModel {
    var nrepo = NewsRepo()
    func signIn(email:String, password: String, completion: @escaping (Error?) -> Void) {
        nrepo.signIn(email: email, password: password) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
