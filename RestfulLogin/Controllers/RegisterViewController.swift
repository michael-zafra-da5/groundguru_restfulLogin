//
//  RegisterViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import Foundation
import UIKit
import FirebaseFirestore

class RegisterViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextfield: UITextField!
    
    override func viewDidLoad() {
        confirmTextfield.delegate = self
        confirmTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if (passwordTextField.text != "") {
            if (passwordTextField.text == confirmTextfield.text) {
                registerButton.isEnabled = true
            } else {
                registerButton.isEnabled = false
            }
        } else {
            registerButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        if  passwordTextField.text != confirmTextfield.text {
            let alert = UIAlertController(title: "Error", message: "Password mismatch", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": nameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "password": confirmTextfield.text ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let alert = UIAlertController(title: "Registration", message: "Registration Successful", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in 
                    self.dismiss(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
