//
//  MenuOption.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case subscribeToPushChClientId
    case publishToChannel
    case subscribePushCh
    case unsubscribePushCh
    case publishPushNotification

    var description: String {
        switch self {
            
        case .subscribeToPushChClientId: return "Sub to push channel with clientId"
        case .unsubscribePushCh: return "Unsub from push channel"
        case .publishToChannel: return "Pub to channel"
        case .subscribePushCh: return "Sub to channel"
        case .publishPushNotification: return "Send push notification"
        }
        
    }


}
