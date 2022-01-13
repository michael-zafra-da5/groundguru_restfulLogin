//
//  RegisterViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import Foundation
import UIKit
import Alamofire

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
        
        let parameters: [String: Any] = [
            "name" : nameTextField.text ?? "",
            "email" : emailTextField.text ?? "",
            "password" : passwordTextField.text ?? ""
        ]
        AF.request(
            "https://reqres.in/api/users",
            method: .post,
            parameters: parameters)
            .responseString(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    //end loading..
                    print("value**: \(value)")
                    do {
                        let data = try value.data(using: .utf8)!
                        print("data \(data)")
                        let decoder = JSONDecoder()
                        if let responseListData = try? decoder.decode(RegisterResponse.self, from: data) {
                            print("responseListData \(responseListData)")
                        }
                    } catch {
                        // handle error
                        print("error")
                    }
                case .failure(let error):
                    //end loading..
                    print(error)
                    let alert = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
    }
}
