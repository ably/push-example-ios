//
//  SettingsController.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit

class SubToPushChClientId: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "F9A01B")
        configureUI()
        
        //client Id input field ui
        let txtClientId = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width - 20.0 , height: 50.0))
        txtClientId.backgroundColor = .white
        txtClientId.borderStyle = .line
        txtClientId.keyboardAppearance = .dark
        txtClientId.keyboardType = .default
        txtClientId.placeholder = "Enter client id"
        txtClientId.font = UIFont.systemFont(ofSize: 15.0)
        txtClientId.delegate = self
        self.view.addSubview(txtClientId)
        
        //push notification publish button ui
        let publishPush = UIButton.init(type: .system)
        publishPush.frame = CGRect(x: 50, y: 300, width: 300, height: 52)
        publishPush.setTitle("Send a push notification to this client", for: .normal)
        publishPush.layer.borderWidth = 0.6
        publishPush.layer.borderColor = UIColor(hexFromString: "333333").cgColor
        publishPush.backgroundColor = UIColor(hexFromString: "333333")
        publishPush.setTitleColor(UIColor(hexFromString: "FFFFFF"), for: .normal)
        publishPush.layer.cornerRadius = 15.0
        publishPush.center.x = self.view.center.x
        publishPush.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        publishPush.addTarget(self, action: #selector(publishPushClicked(_ :)), for: .touchUpInside)
        self.view.addSubview(publishPush)
    }
    
    // MARK: Selectors
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    @objc func publishPushClicked(_ : UIButton) {
        print("Clicked publish push")
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
