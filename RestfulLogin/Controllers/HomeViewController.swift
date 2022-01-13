//
//  HomeViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import Foundation
import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        let db = Firestore.firestore()
        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
              print("Current data: \(data)")
                self.message.text = "\(data["message"] ?? "")"
            }
    }
    
    @IBAction func actionSend(_ sender: Any) {
        let db = Firestore.firestore()
//        var ref: DocumentReference? = nil
//        ref = db.collection("messages").document(data: [
//            "message": messageTextField.text ?? ""
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj").setData([
            "message": messageTextField.text ?? ""
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
}
