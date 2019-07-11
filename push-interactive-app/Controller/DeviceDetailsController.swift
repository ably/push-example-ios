//
//  DeviceDetailsController.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 11/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit
import UserNotifications
import Ably

class DeviceDetailsController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    var delegate: HomeControllerDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        configureUI()
        
        let txtDeviceDetails = UITextView(frame: CGRect(x: 10.0, y: 150.0, width: UIScreen.main.bounds.size.width - 50.0 , height: UIScreen.main.bounds.size.height))
        txtDeviceDetails.backgroundColor = .white
        //txtDeviceDetails.borderStyle = .line
        txtDeviceDetails.keyboardAppearance = .dark
        txtDeviceDetails.keyboardType = .default
        txtDeviceDetails.font = UIFont.systemFont(ofSize: 18.0)
        txtDeviceDetails.textContainerInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        txtDeviceDetails.text = "1. ClientId: " + appDelegate.myClientId + "\n\n\n2. DeviceId: " + appDelegate.myDeviceId + "\n\n\n3. DeviceToken: " + appDelegate.myDeviceToken + "\n\n\n4. Push channel: " + appDelegate.myPushChannel
        //txtDeviceDetails.append =
        self.view.addSubview(txtDeviceDetails)
    }
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Local device details"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
    }
}
