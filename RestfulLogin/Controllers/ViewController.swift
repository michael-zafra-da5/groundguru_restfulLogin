//
//  ViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        stackView.setCustomSpacing(18, after: emailTextField)
        stackView.setCustomSpacing(24, after: passwordTextField)
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if email == "" || password == "" {
            let alert = UIAlertController(title: "Error", message: "Email or Password is required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let db = Firestore.firestore()
        var isRegistered = false
        let userRef = db.collection("users")
        userRef.whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: password)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    isRegistered = true
                }
                
                if isRegistered {
                    print("Login")
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let detailVC = storyboard.instantiateViewController(withIdentifier: "homeSB") as! HomeViewController
                    detailVC.modalPresentationStyle = .fullScreen
                    self.present(detailVC, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Login", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "registerSB") as! RegisterViewController
        self.present(detailVC, animated: true, completion: nil)
    }
}

