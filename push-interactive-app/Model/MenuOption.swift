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
    case publishPushNotification
    case publishToChannel
    case unsubscribePushCh
    case subscribePushCh


    var description: String {
        switch self {
        case .subscribeToPushChClientId: return "Sub/Unsub push channel with clientId"
        case .publishPushNotification: return "Publish push notifications"
        case .publishToChannel: return "Pub to channel"
        case .unsubscribePushCh: return "TODO from push channel"
        case .subscribePushCh: return "Sub to channel"
        }
        
    }


}
