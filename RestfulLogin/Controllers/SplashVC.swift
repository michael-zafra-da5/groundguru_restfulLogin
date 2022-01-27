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
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLeft -= 1
            if(self.timeLeft==0){
                timer.invalidate()
                
                let userID = UserDefaults.standard.string(forKey: Constants().userID)
                print("😅userID \(userID)😅")
                if userID != nil {
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let detailVC = storyboard.instantiateViewController(withIdentifier: "homeSB") as! HomeViewController
                    detailVC.modalPresentationStyle = .fullScreen
                    self.present(detailVC, animated: true, completion: nil)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let detailVC = storyboard.instantiateViewController(withIdentifier: "loginSB") as! ViewController
                    detailVC.modalPresentationStyle = .fullScreen
                    self.present(detailVC, animated: true, completion: nil)
                }
            }
        }
    }
}
