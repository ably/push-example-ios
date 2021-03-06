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

class SubUnsubPushController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    //var realtime: ARTRealtime!
    var delegate: HomeControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        configureUI()

        //subscribe to push channel with client id button ui
        let subToPushChannelClientId = UIButton.init(type: .system)
        subToPushChannelClientId.frame = CGRect(x: 80, y: 180, width: 300, height: 52)
        subToPushChannelClientId.setTitle("Subscribe clientID to push", for: .normal)
        subToPushChannelClientId.layer.borderWidth = 0.6
        subToPushChannelClientId.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        subToPushChannelClientId.backgroundColor = UIColor(hexFromString: "333333")
        subToPushChannelClientId.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        subToPushChannelClientId.layer.cornerRadius = 15.0
        subToPushChannelClientId.center.x = self.view.center.x
        subToPushChannelClientId.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        subToPushChannelClientId.addTarget(self, action: #selector(subToPushClientIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(subToPushChannelClientId)
        
        //unsubscribe to push channel with client id button ui
        let unsubFromPushChannelClientId = UIButton.init(type: .system)
        unsubFromPushChannelClientId.frame = CGRect(x: 80, y: 280, width: 300, height: 52)
        unsubFromPushChannelClientId.setTitle("Unsubscribe clientID from push", for: .normal)
        unsubFromPushChannelClientId.layer.borderWidth = 0.6
        unsubFromPushChannelClientId.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        unsubFromPushChannelClientId.backgroundColor = UIColor(hexFromString: "333333")
        unsubFromPushChannelClientId.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        unsubFromPushChannelClientId.layer.cornerRadius = 15.0
        unsubFromPushChannelClientId.center.x = self.view.center.x
        unsubFromPushChannelClientId.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        unsubFromPushChannelClientId.addTarget(self, action: #selector(unsubFromPushClientIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(unsubFromPushChannelClientId)
        
        //subscribe to push channel with device id button ui
        let subToPushChannelDeviceId = UIButton.init(type: .system)
        subToPushChannelDeviceId.frame = CGRect(x: 80, y: 380, width: 300, height: 52)
        subToPushChannelDeviceId.setTitle("Subscribe deviceId to push", for: .normal)
        subToPushChannelDeviceId.layer.borderWidth = 0.6
        subToPushChannelDeviceId.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        subToPushChannelDeviceId.backgroundColor = UIColor(hexFromString: "333333")
        subToPushChannelDeviceId.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        subToPushChannelDeviceId.layer.cornerRadius = 15.0
        subToPushChannelDeviceId.center.x = self.view.center.x
        subToPushChannelDeviceId.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        subToPushChannelDeviceId.addTarget(self, action: #selector(subToPushDeviceIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(subToPushChannelDeviceId)
        
        //unsubscribe to push channel with device id button ui
        let unsubFromPushChannel = UIButton.init(type: .system)
        unsubFromPushChannel.frame = CGRect(x: 80, y: 480, width: 300, height: 52)
        unsubFromPushChannel.setTitle("Unsubscribe deviceId from push", for: .normal)
        unsubFromPushChannel.layer.borderWidth = 0.6
        unsubFromPushChannel.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        unsubFromPushChannel.backgroundColor = UIColor(hexFromString: "333333")
        unsubFromPushChannel.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        unsubFromPushChannel.layer.cornerRadius = 15.0
        unsubFromPushChannel.center.x = self.view.center.x
        unsubFromPushChannel.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        unsubFromPushChannel.addTarget(self, action: #selector(unsubFromPushDeviceIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(unsubFromPushChannel)
    }
    
    // MARK: Selectors
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    
    @objc func subToPushClientIdClicked(_ : UIButton) {
        print("Clicked subscribe to push channel with clientId")
        let pushChannel = appDelegate.realtime.channels.get(appDelegate.myPushChannel)
        pushChannel.attach() { (err) in
            print("** channel attached, err=\(String(describing: err))")
            print("** attempting to unsub device")
            pushChannel.push.unsubscribeDevice() { (err) in
                if (err != nil){
                    print("unsubscribe deviceId failed")
                    return
                }
                DispatchQueue.main.async {
                    print("unsubscribing device id")
                }
                print("** channel.push.unsubscribeClient: err=\(String(describing: err))")
                print("unsubscribing device id success")
                self.appDelegate.subscribed = false
            }
            print("** attempting to subscribe to push with clientId")
            pushChannel.push.subscribeClient() { (err) in
                if (err != nil){
                    let alert = UIAlertController(title: "Error", message: "Subscribe client failed", preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                DispatchQueue.main.async {
                    //print("** device ID \(self.realtime.device.id)")
                    print("** inside async clientId")
                }
                print("** channel.push.subscribeClient: err=\(String(describing: err))")
                let alert = UIAlertController(title: "Success", message: "Subscribe client success", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.appDelegate.subscribed = true
            }
        }
    }
    
    @objc func unsubFromPushClientIdClicked(_ : UIButton) {
        print("Clicked unsubscribe from push channel with clientId")
        let pushChannel = appDelegate.realtime.channels.get(appDelegate.myPushChannel)
            
        pushChannel.push.unsubscribeClient() { (err) in
            if (err != nil){
                let alert = UIAlertController(title: "Error", message: "Unsubscribe client failed", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {
                print("** device ID \(self.appDelegate.realtime.device.id)")
            }
            let alert = UIAlertController(title: "Success", message: "Unsubscribe client success", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("** channel.push.unsubscribeClient: err=\(String(describing: err))")
            self.appDelegate.subscribed = false
        }
    }
    
    @objc func subToPushDeviceIdClicked(_ : UIButton) {
        print("Clicked subscribe to push channel with deviceId")
        let pushChannel = appDelegate.realtime.channels.get(appDelegate.myPushChannel)
        pushChannel.attach() { (err) in
            print("** channel attached, err=\(String(describing: err))")
            print("** attempting to subscribe to push with deviceId")
            pushChannel.push.unsubscribeClient() { (err) in
                if (err != nil){
                    print("unsubscribed clientId")
                    return
                }
                DispatchQueue.main.async {
                    print("subscribing device id")
                }
                print("** channel.push.unsubscribeClient: err=\(String(describing: err))")
                self.appDelegate.subscribed = false
            }
            pushChannel.push.subscribeDevice() { (err) in
                if (err != nil){
                    let alert = UIAlertController(title: "Error", message: "Subscribe device failed", preferredStyle: .alert)
                    alert.addAction(.init(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                DispatchQueue.main.async {
                    //print("** device ID \(self.realtime.device.id)")
                    print("** inside async")
                }
                print("** channel.push.subscribeDevice: err=\(String(describing: err))")
                let alert = UIAlertController(title: "Success", message: "Subscribe device success", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.appDelegate.subscribed = true
            }
        }
    }
    
    @objc func unsubFromPushDeviceIdClicked(_ : UIButton) {
        print("Clicked unsubscribe from push channel with clientId")
        let pushChannel = appDelegate.realtime.channels.get(appDelegate.myPushChannel)
        
        pushChannel.push.unsubscribeDevice() { (err) in
            if (err != nil){
                let alert = UIAlertController(title: "Error", message: "Unsubscribe device failed", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {
                print("** device ID \(self.appDelegate.realtime.device.id)")
            }
            let alert = UIAlertController(title: "Success", message: "Unsubscribe device success", preferredStyle: .alert)
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
        navigationItem.title = "Subscribe to push channel"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
}
