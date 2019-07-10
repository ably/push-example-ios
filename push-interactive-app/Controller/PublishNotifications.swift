//
//  PublishNotifications.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 10/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit
import UserNotifications
import Ably

class PublishNotifications: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    var delegate: HomeControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        configureUI()
        
        //direct deviceID
        let publishDirectWithDeviceId = UIButton.init(type: .system)
        publishDirectWithDeviceId.frame = CGRect(x: 50, y: 180, width: 300, height: 52)
        publishDirectWithDeviceId.setTitle("Publish directly with deviceId", for: .normal)
        publishDirectWithDeviceId.layer.borderWidth = 0.6
        publishDirectWithDeviceId.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        publishDirectWithDeviceId.backgroundColor = UIColor(hexFromString: "333333")
        publishDirectWithDeviceId.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        publishDirectWithDeviceId.layer.cornerRadius = 15.0
        publishDirectWithDeviceId.center.x = self.view.center.x
        publishDirectWithDeviceId.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        publishDirectWithDeviceId.addTarget(self, action: #selector(pubDirectWithDeviceIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(publishDirectWithDeviceId)
        
        //direct clientID
        let publishDirectWithClientId = UIButton.init(type: .system)
        publishDirectWithClientId.frame = CGRect(x: 50, y: 280, width: 300, height: 52)
        publishDirectWithClientId.setTitle("Publish directly with clientId", for: .normal)
        publishDirectWithClientId.layer.borderWidth = 0.6
        publishDirectWithClientId.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        publishDirectWithClientId.backgroundColor = UIColor(hexFromString: "333333")
        publishDirectWithClientId.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        publishDirectWithClientId.layer.cornerRadius = 15.0
        publishDirectWithClientId.center.x = self.view.center.x
        publishDirectWithClientId.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        publishDirectWithClientId.addTarget(self, action: #selector(pubDirectWithClientIdClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(publishDirectWithClientId)
        
        //direct native recipient
        let publishDirectNative = UIButton.init(type: .system)
        publishDirectNative .frame = CGRect(x: 50, y: 380, width: 300, height: 52)
        publishDirectNative .setTitle("Publish directly with native details", for: .normal)
        publishDirectNative .layer.borderWidth = 0.6
        publishDirectNative .layer.borderColor = UIColor(hexFromString: "333333").cgColor
        publishDirectNative .backgroundColor = UIColor(hexFromString: "333333")
        publishDirectNative .setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        publishDirectNative .layer.cornerRadius = 15.0
        publishDirectNative .center.x = self.view.center.x
        publishDirectNative .contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        publishDirectNative .addTarget(self, action: #selector(pubDirectWithNativeRecipientClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(publishDirectNative )
        
        //channel publish
        let publishViaChannel = UIButton.init(type: .system)
        publishViaChannel .frame = CGRect(x: 50, y: 480, width: 300, height: 52)
        publishViaChannel .setTitle("Publish directly with native details", for: .normal)
        publishViaChannel .layer.borderWidth = 0.6
        publishViaChannel .layer.borderColor = UIColor(hexFromString: "333333").cgColor
        publishViaChannel .backgroundColor = UIColor(hexFromString: "333333")
        publishViaChannel .setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        publishViaChannel .layer.cornerRadius = 15.0
        publishViaChannel .center.x = self.view.center.x
        publishViaChannel .contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        publishViaChannel .addTarget(self, action: #selector(pubViaChannelClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(publishDirectNative )
    }
    
    // MARK: Selectors
    @objc func pubDirectWithDeviceIdClicked(_ : UIButton) {
        print("Clicked publish direct with deviceId")
        let recipient: [String: Any] = [
            "deviceId": "xxxxxxxxxxxxxx"
        ]
        let data: [String: Any] = [
            "notification": [
                "title": "Hello from Ably!",
                "body": "This was sent from directly with deviceId"
            ],
            "data": [
                "foo": "bar",
                "baz": "qux"
            ]
        ]
        appDelegate.realtime.push.admin.publish(recipient, data: data)

    }
    
    @objc func pubDirectWithClientIdClicked(_ : UIButton) {
        print("Clicked publish direct with clientId")
        let recipient: [String: Any] = [
            "clientId": "xxxxxxxxxxxxxx"
        ]
        let data: [String: Any] = [
            "notification": [
                "title": "Hello from Ably!",
                "body": "This was sent from directly with clientId"
            ],
            "data": [
                "foo": "bar",
                "baz": "qux"
            ]
        ]
        appDelegate.realtime.push.admin.publish(recipient, data: data)
        
    }
    
    @objc func pubDirectWithNativeRecipientClicked(_ : UIButton) {
        print("Clicked publish direct with Native recipient details")
        let recipient: [String: Any] = [
            "transportType": "apns",
            "deviceToken": "XXXXXXXX"
        ]
        
        let data: [String: Any] = [
            "notification": [
                "title": "Hello from Ably!",
                "body": "Example push notification from Ably."
            ],
            "data": [
                "foo": "bar",
                "baz": "qux"
            ]
        ]
        appDelegate.realtime.push.admin.publish(recipient, data: data)
    }
    
    @objc func pubViaChannelClicked(_ : UIButton) {
        print("Clicked unsubscribe from push channel")
        let pushChannel = appDelegate.realtime.channels.get("push")
        
        var message = ARTMessage(name: "example", data: "rest data")
        message.extras = [
            "push": [
                "notification": [
                    "title": "Hello from Ably!",
                    "body": "This was sent from an Ably channel"
                ],
                "data": [
                    "foo": "bar",
                    "baz": "qux"
                ]
            ]
            ] as ARTJsonCompatible
        pushChannel.publish([message])
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Publish Push Notifications"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
}
