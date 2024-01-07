//
//  Profile.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 7.01.2024.
//

import UIKit

class Profile: UIViewController {
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logOutButton(_ sender: Any) {
        viewModel.signOut { success in
            if success {
                self.performSegue(withIdentifier: "toLoginScreen", sender: nil)
            } else {
                self.makeAlert(titleInput: "Error!", messageInput: "Logout failed")
            }
        }
    }
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
