//
//  MenuOption.swift
//  push-interactive-app
//
//  Created by Srushtika Neelakantam on 09/07/2019.
//  Copyright © 2019 Srushtika Neelakantam. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case subscribeToChannel
    case publishToChannel
    case subscribePushCh
    case unsubscribePushCh
    case publishPushNotification

    var description: String {
        switch self {
            
        case .subscribeToChannel: return "Sub to channel"
        case .publishToChannel: return "Pub to channel"
        case .subscribePushCh: return "Sub to push channel"
        case .unsubscribePushCh: return "Unsub from push channel"
        case .publishPushNotification: return "Send push notification"
        }
        
    }


}
