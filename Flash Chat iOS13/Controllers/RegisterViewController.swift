//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Khalil Panahi
//

import Firebase
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    @IBAction func registerPressed(_: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let e = error {
                    print(error)
                } else {
                    // Navigate to chatviewcontroller
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}
