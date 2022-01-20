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

enum HashKey: String {
    case message = "message"
    case sender = "sender"
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    var received: Message? = nil
    
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
                
                print("Current data: \(data[HashKey.message.rawValue])")
                if let message = data.asMessage() {
                    print("Current data: \(message)")
                    self.message.text = "\(message.message)"
                    self.received = message
                }
            }
        
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
        let message = Message(
            message: messageTextField.text ?? "",
            sender: received?.sender ?? ""
        ).asDictionary()
        
        //Add or Update fields via Model
        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj").setData(message) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        //Add or Update fields via default dictionary
        //setData will create new document with parameter fields
        //updateData will update the document data with specific field
//        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj").updateData([
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
//        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj").delete() { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
//
//        //Delete Field data
//        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj").updateData([
//            "message": FieldValue.delete(),
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
    }
}
