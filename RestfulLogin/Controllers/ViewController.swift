//
//  ViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import UIKit
import FirebaseFirestore
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var versionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkAppVersion()
    }
    
    private func setupView() {
        stackView.setCustomSpacing(18, after: emailTextField)
        stackView.setCustomSpacing(24, after: passwordTextField)
        
        versionLbl.font = UIFont(name: Fonts.regular, size: 16)
        
        let attributedString = NSMutableAttributedString(string: "Just click here to register", attributes: nil)
//        let justRange = (attributedString.string as NSString).range(of: "Just")
        let dontRange = (attributedString.string as NSString).range(of: "click here")
        attributedString.setAttributes([
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.blue
        ], range: dontRange)
//        attributedString.setAttributes([
//            .font: UIFont.boldSystemFont(ofSize: 10),
////            .link: ""
//            .foregroundColor: UIColor.red
//        ], range: justRange)

        versionLbl.attributedText = attributedString
        versionLbl.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
        versionLbl.addGestureRecognizer(tap)
    }
    
    @objc func tapLabel(tap: UITapGestureRecognizer) {
        guard let range = self.versionLbl.text?.range(of: "click here")?.nsRange else {
            return
        }
        
        if tap.didTapAttributedTextInLabel(label: self.versionLbl, inRange: range) {
            // Substring tapped
            print("tap tap tap")
            let storyboard = UIStoryboard(name: "Register", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "registerSB") as! RegisterViewController
            self.present(detailVC, animated: true, completion: nil)
            
            //Opening Web URL
//            if let url = URL(string: "https://www.google.com/"), UIApplication.shared.canOpenURL(url) {
//               if #available(iOS 10.0, *) {
//                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
//               } else {
//                  UIApplication.shared.openURL(url)
//               }
//            }
        }
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
        
        self.loginViaFirebase(email: email, password: password)
//        self.loginViaAPI(email: email, password: password)
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "registerSB") as! RegisterViewController
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func loginViaFirebase(email:String, password:String){
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
    
    func checkAppVersion() {
        let params: Parameters = ["platform": 1]
        AF.request(
            "http://192.168.254.141:8000/api/platform/versionChecker",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: nil
        )
//            .validate(statusCode: 200 ..< 299)
            .responseString(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print("value**: \(value)")
                    do {
                        let data = try value.data(using: .utf8)!
                        print("data \(data)")
                        let decoder = JSONDecoder()
                        if let responseData = try? decoder.decode(AppVersion.self, from: data) {
                            print("responseData \(responseData.version)")
//                            responseData
                        }
                    } catch {
                        // handle error
                        print("error")
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func loginViaAPI(email:String, password:String) {
        let params: Parameters = ["unique": email, "password": password]
        AF.request(
            "http://192.168.254.141:8000/api/auth/login",
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: nil
        )
//            .validate(statusCode: 200 ..< 299) // For validation for status code 200 "Success"
            .responseString(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print("value**: \(value)")
                    do {
                        let data = try value.data(using: .utf8)!
                        let decoder = JSONDecoder()
                        if let responseData = try? decoder.decode(AppVersion.self, from: data) {
                            print("responseData \(responseData.version)")
//                            responseData
                        }
                    } catch {
                        // handle error
                        print("error")
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
