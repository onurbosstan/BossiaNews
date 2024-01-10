//
//  ViewController.swift
//  BossiaNews
//
//  Created by ONUR BOSTAN on 3.01.2024.
//

import UIKit
import FirebaseAuth

class LogIn: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let viewModel = LogInViewModel()
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            self.performSegue(withIdentifier: "toHomeVC", sender: nil)
        }
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func logInButton(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text {
            viewModel.signIn(email: email, password: password) { error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: "Username or password is wrong. Please try again, if you do not have an account, please register.")
                } else {
                    self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                }
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

