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
    var txtDeviceDetails: UITextView!
    
    var device: ARTLocalDevice {
        return appDelegate.realtime.device
    }
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateDetailsText()
    }
    
    func updateDetailsText() {
        txtDeviceDetails.text =
        "1. ClientId:\n\(device.clientId ?? "<empty>")" +
        "\n\n\n2. DeviceId:\n\(device.id)" +
        "\n\n\n3. DevicePushDetails recipient:\n\(device.push.recipient)" +
        "\n\n\n4. DeviceIdentityTokenDetails:\n\(device.identityTokenDetails?.description ?? "<empty>")"
    }
    
    func configureUI() {
        txtDeviceDetails = UITextView(frame: CGRect(x: 10.0, y: 150.0, width: UIScreen.main.bounds.size.width - 50.0 , height: UIScreen.main.bounds.size.height))
        txtDeviceDetails.backgroundColor = .systemBackground
        //txtDeviceDetails.borderStyle = .line
        txtDeviceDetails.keyboardAppearance = .dark
        txtDeviceDetails.keyboardType = .default
        txtDeviceDetails.font = UIFont.systemFont(ofSize: 18.0)
        txtDeviceDetails.textContainerInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        self.view = txtDeviceDetails
    }
}
