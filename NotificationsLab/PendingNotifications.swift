//
//  PendingNotifications.swift
//  NotificationsLab
//
//  Created by Jaheed Haynes on 2/20/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation
import UserNotifications

class PendingNotification {
    public func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> ()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print("there are \(requests.count) pending requests")
            completion(requests)
        }
    }
}
