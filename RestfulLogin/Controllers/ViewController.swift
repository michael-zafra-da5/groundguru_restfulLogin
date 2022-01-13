//
//  ViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import UIKit

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
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "registerSB") as! RegisterViewController
        self.present(detailVC, animated: true, completion: nil)
    }
}

