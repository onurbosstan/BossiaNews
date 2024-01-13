//
//  ForgotPasswordViewModel.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 4.01.2024.
//

import Foundation

class ForgotPasswordViewModel {
    var nrepo = NewsRepo()
    func forgotPassword(email:String, completion: @escaping (Error?) -> Void) {
        nrepo.forgotPassword(email: email) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
