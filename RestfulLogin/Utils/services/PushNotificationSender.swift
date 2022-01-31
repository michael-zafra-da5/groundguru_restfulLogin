//
//  PushNotificationSender.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/31/22.
//

import UIKit

class PushNotificationSender {
    func sendPushNotification(to token: [String], title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = [
//            "to" : token, //Single Token
            "registration_ids" : [token], //Multiple token
            "notification" : ["title" : title, "body" : body],
            "data" : ["user" : "test_id"]
        ]
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAA_qBu9hE:APA91bELderPqtjlIYrYNM8EJFBd9aPTzCbbNHjXmz2aVEprj7VIHcoN-9sxyHr0iq6ULNJAuKYo-myYvRhGmaz-wGbTu7VidA_N-jMsoZgv-0vMGRHzj4iuiGGFiDfiyMiQ5Kj3KMen", forHTTPHeaderField: "Authorization")
        
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
