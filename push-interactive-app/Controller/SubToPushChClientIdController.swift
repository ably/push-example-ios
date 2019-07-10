//
//  SettingsController.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit
import UserNotifications
import Ably

class SubToPushChClientId: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    //var realtime: ARTRealtime!
    var delegate: HomeControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        configureUI()
        
        //client Id input field ui
        /*
        let txtClientId = UITextField(frame: CGRect(x: 10.0, y: 150.0, width: UIScreen.main.bounds.size.width - 50.0 , height: 50.0))
        txtClientId.backgroundColor = .white
        txtClientId.borderStyle = .line
        txtClientId.keyboardAppearance = .dark
        txtClientId.keyboardType = .default
        txtClientId.placeholder = "Enter client id"
        txtClientId.font = UIFont.systemFont(ofSize: 15.0)
        txtClientId.delegate = self
        self.view.addSubview(txtClientId)
        */
        
        //subscribe to push channel button ui
        let subToPushChannel = UIButton.init(type: .system)
        subToPushChannel.frame = CGRect(x: 50, y: 280, width: 300, height: 52)
        subToPushChannel.setTitle("Subscribe to push channel", for: .normal)
        subToPushChannel.layer.borderWidth = 0.6
        subToPushChannel.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        subToPushChannel.backgroundColor = UIColor(hexFromString: "333333")
        subToPushChannel.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        subToPushChannel.layer.cornerRadius = 15.0
        subToPushChannel.center.x = self.view.center.x
        subToPushChannel.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        subToPushChannel.addTarget(self, action: #selector(subToPushClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(subToPushChannel)
        
        //unsubscribe to push channel button ui
        let unsubFromPushChannel = UIButton.init(type: .system)
        unsubFromPushChannel.frame = CGRect(x: 50, y: 380, width: 300, height: 52)
        unsubFromPushChannel.setTitle("Unsubscribe from push channel", for: .normal)
        unsubFromPushChannel.layer.borderWidth = 0.6
        unsubFromPushChannel.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        unsubFromPushChannel.backgroundColor = UIColor(hexFromString: "333333")
        unsubFromPushChannel.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        unsubFromPushChannel.layer.cornerRadius = 15.0
        unsubFromPushChannel.center.x = self.view.center.x
        unsubFromPushChannel.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        unsubFromPushChannel.addTarget(self, action: #selector(unsubFromPushClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(unsubFromPushChannel)
    }
    
    // MARK: Selectors
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    @objc func subToPushClicked(_ : UIButton) {
        print("Clicked subscribe to push channel")
        let pushChannel = appDelegate.realtime.channels.get("push")
        pushChannel.attach() { (err) in
            print("** channel attached, err=\(String(describing: err))")
            if (err != nil){
                let alert = UIAlertController(title: "Error", message: "Attach failed", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            print("** device ID \(self.appDelegate.realtime.device.id)")
            pushChannel.push.subscribeClient { (err) in
                if (err != nil){
                    let alert = UIAlertController(title: "Error", message: "Subscribe failed", preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                DispatchQueue.main.async {
                    print("** device ID \(self.appDelegate.realtime.device.id)")
                }
                let alert = UIAlertController(title: "Success", message: "Subcribe success", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("** channel.push.subscribeClient: err=\(String(describing: err))")
                self.appDelegate.subscribed = true
            }
        }
    }
    
    @objc func unsubFromPushClicked(_ : UIButton) {
        print("Clicked unsubscribe from push channel")
        let pushChannel = appDelegate.realtime.channels.get("push")
            
        pushChannel.push.unsubscribeClient() { (err) in
            if (err != nil){
                let alert = UIAlertController(title: "Error", message: "Unsubscribe failed", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {
                print("** device ID \(self.appDelegate.realtime.device.id)")
            }
            let alert = UIAlertController(title: "Success", message: "Unsubscribe success", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("** channel.push.subscribeClient: err=\(String(describing: err))")
            self.appDelegate.subscribed = false
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Subscribe to push channel with client Id"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
}
