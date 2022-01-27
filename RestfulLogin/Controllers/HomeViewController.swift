//
//  HomeViewController.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import AVKit

enum MessageKey: String {
    case message = "message"
    case sender = "sender"
}

enum AnimalKey: String {
    case message = "message"
    case name = "name"
    case description = "description"
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    var received: Message? = nil
    
    override func viewDidLoad() {
        
        let email = UserDefaults.standard.string(forKey: Constants().userDataKey)
        let userID = UserDefaults.standard.string(forKey: Constants().userID)
        print("Home Page: \(userID ?? "") \(email ?? "")")
        
        let db = Firestore.firestore()
        db.collection("messages").document(userID ?? "")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let firebaseData = document.data() else {
                    print("Document data was empty.")
                    return
                }
                
                print("Current data: \(firebaseData[MessageKey.message.rawValue] ?? "")")
                if let data = firebaseData.asMessage() {
                    print("Current data: \(data)")
                    self.message.text = "\(data.message)"
                    self.received = data
                }
            }
        
//        db.collection("messages").whereField("state", isEqualTo: "CA")
//            .addSnapshotListener { querySnapshot, error in
//                guard let snapshot = querySnapshot else {
//                    print("Error fetching snapshots: \(error!)")
//                    return
//                }
//                snapshot.documentChanges.forEach { diff in
//                    if (diff.type == .added) {
//                        print("New city: \(diff.document.data())")
//                    }
//                    if (diff.type == .modified) {
//                        print("Modified city: \(diff.document.data())")
//                    }
//                    if (diff.type == .removed) {
//                        print("Removed city: \(diff.document.data())")
//                    }
//                }
//            }
        
        guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        
        let videoURL = URL(fileURLWithPath: path)
        //        let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "myAlert"
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { _ in
            UserDefaults.standard.removeObject(forKey: Constants().userID)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "loginSB") as! ViewController
            detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        let message = Message(message: messageTextField.text ?? "", sender: received?.sender ?? "").asDictionary()
        
//        let message2 = asDictionary(message: Message(message: messageTextField.text ?? "", sender: received?.sender ?? ""))
        
        let userID = UserDefaults.standard.string(forKey: Constants().userID) ?? ""
        //Add or Update fields via Model
        db.collection("messages").document(userID).setData(message) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //Add or Update fields via default dictionary
        //setData will create new document with parameter fields
        //updateData will update the document data with specific field
//        db.collection("messages").document("JozpmVcsr2Lag6oF8TTm").updateData([
//            HashKey.message.rawValue: messageTextField.text ?? "",
//            HashKey.sender.rawValue: "sample@gmail.com"
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//
//        //Delete Document
//        db.collection("messages").document("JozpmVcsr2Lag6oF8TTm").delete() { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
//
//        //Delete Field data
//        db.collection("messages").document("JozpmVcsr2Lag6oF8TTm").updateData([
//            "message": FieldValue.delete(),
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
    }
    
    func asDictionary(message:Message) -> [String: Any] {
        do {
            //asDictionary(Testing)
            let data = try JSONEncoder().encode(message)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
