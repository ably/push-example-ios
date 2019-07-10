//
//  HomeController.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit
import UserNotifications
import Ably

class HomeController: UIViewController{
    
    //MARK: Properties
    var realtime: ARTRealtime!
    var delegate: HomeControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Init
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        
        //activate button ui
        let activateButton = UIButton.init(type: .system)
        activateButton.frame = CGRect(x: 50, y: 300, width: 300, height: 52)
        activateButton.setTitle("Activate Push on this device", for: .normal)
        activateButton.layer.borderWidth = 0.6
        activateButton.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        activateButton.backgroundColor = UIColor(hexFromString: "333333")
        activateButton.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        activateButton.layer.cornerRadius = 15.0
        activateButton.center.x = self.view.center.x
        activateButton.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        activateButton.addTarget(self, action: #selector(activateButtonClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(activateButton)
        
        //deactivate button ui
        let deactivateButton = UIButton.init(type: .system)
        deactivateButton.frame = CGRect(x: 50, y: 400, width: 300, height: 52)
        deactivateButton.setTitle("Deactivate Push on this device", for: .normal)
        deactivateButton.layer.borderWidth = 0.6
        deactivateButton.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        deactivateButton.backgroundColor = UIColor(hexFromString: "333333")
        deactivateButton.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        deactivateButton.layer.cornerRadius = 15.0
        deactivateButton.center.x = self.view.center.x
        deactivateButton.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        deactivateButton.addTarget(self, action: #selector(deactivateButtonClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(deactivateButton)
        
        
        configureNavigationBar()
    }
    
    //MARK: Handlers
    
    
    //activate button handler
    @objc func activateButtonClicked(_ : UIButton) {
        print("Clicked activate")
        appDelegate.realtime.push.activate()
    }
    
    //deactivate button handler
    @objc func deactivateButtonClicked(_ : UIButton) {
        print("Clicked deactivate")
        appDelegate.realtime.push.deactivate()
    }
    
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Ably Push Notifications"
        navigationItem.leftBarButtonItem  = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
            
    }
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


