//
//  SplashVC.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/26/22.
//

import Foundation
import UIKit
import SnapKit

class SplashVC: UIViewController {
    
    var timeLeft = 10
    
    let logo : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "logo_svg")
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    override func viewDidLoad() {
        print("😅Load Splash😅")
        setUpView()
        initTimer()
    }
    
    func setUpView() {
        view.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.height.equalTo(250)
            make.width.equalTo(250)
            make.centerX.equalTo(view)
        }
    }
    
    private func initTimer() {
        // For Countdown
        //        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        //            self.timeLeft -= 1
        //            print("Time Left \(self.timeLeft)")
        //            if(self.timeLeft==0){
        //                timer.invalidate()
        //
        //                let userID = UserDefaults.standard.string(forKey: Constants().userID)
        //                print("😅userID \(userID ?? "")😅")
        //                if userID != nil {
        //                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
        //                    let detailVC = storyboard.instantiateViewController(withIdentifier: "homeSB") as! HomeViewController
        //                    detailVC.modalPresentationStyle = .fullScreen
        //                    self.present(detailVC, animated: true, completion: nil)
        //                } else {
        //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                    let detailVC = storyboard.instantiateViewController(withIdentifier: "loginSB") as! ViewController
        //                    detailVC.modalPresentationStyle = .fullScreen
        //                    self.present(detailVC, animated: true, completion: nil)
        //                }
        //            }
        //        }
        
        // For based on interval
        print("Timer start \(Date())")
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            print("Timer finish \(Date())")
            timer.invalidate()
            let userID = UserDefaults.standard.string(forKey: Constants().userID)
            print("😅userID \(userID ?? "")😅")
            
            //normal conditional statement for opening page
//            if userID != nil {
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                let detailVC = storyboard.instantiateViewController(withIdentifier: "homeSB") as! HomeViewController
//                detailVC.modalPresentationStyle = .fullScreen
//                self.present(detailVC, animated: true, completion: nil)
//            } else {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let detailVC = storyboard.instantiateViewController(withIdentifier: "loginSB") as! ViewController
//                detailVC.modalPresentationStyle = .fullScreen
//                self.present(detailVC, animated: true, completion: nil)
//            }
            
            //Simplified conditional statement for opening page
            let storyboardName = (userID != nil ? "Home" : "Main")
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: storyboardName == "Main" ? "loginSB" : "homeSB")
            detailVC.modalPresentationStyle = .fullScreen
            self.present(storyboardName == "Main" ? (detailVC as! ViewController) : (detailVC as! HomeViewController), animated: true, completion: nil)
        }
    }
}
