//
//  MenuOption.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case subUnsubPush
    case publishPushNotification
    case showLocalDeviceDetails


    var description: String {
        switch self {
        case .subUnsubPush: return "Sub/Unsub push channel"
        case .publishPushNotification: return "Publish push notifications"
        case .showLocalDeviceDetails: return "Show local device details"
        }
        
    }


}
