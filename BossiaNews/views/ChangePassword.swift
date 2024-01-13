//
//  ChangePassword.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 13.01.2024.
//

import UIKit

class ChangePassword: UIViewController {
    @IBOutlet weak var newPasswordText: UITextField!
    var viewModel = ChangePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func confirmButton(_ sender: Any) {
        guard let newPassword = newPasswordText.text, !newPassword.isEmpty else {
            self.makeAlert(titleInput: "Error!", messageInput: "Please enter a new password.")
            return
        }
        viewModel.changePassword(newPassword: newPassword) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: "Password change failed: \(error.localizedDescription)")
            } else {
                self.makeAlert(titleInput: "Success!", messageInput: "Password change successfully")
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
