//
//  Register.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 4.01.2024.
//

import UIKit
import FirebaseAuth

class Register: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var viewModel = NewsRepo()
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    @IBAction func registerButton(_ sender: Any) {
        if let email = self.emailText.text, let password = self.passwordText.text {
            self.viewModel.signUp(email: email, password: password) { _ in
                self.makeAlert(titleInput: "Success!", messageInput: "You have successfully registered.")
            }
        }
    }
    @IBAction func hidePasswordButton(_ sender: Any) {
        if iconClick {
            passwordText.isSecureTextEntry = false
        } else {
            passwordText.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
