//
//  UserNotification.swift
//  Alarm2.0
//
//  Created by 羅承志 on 2022/3/8.
//

import UIKit

class UserNotification {
    
    static let userNotificationCenter = UNUserNotificationCenter.current()
    
    static func addNotification(alarm: Alarm) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
//        print("components: \(components)")
        let content = UNMutableNotificationContent()
        content.title = alarm.label
        content.body = "Hello \(alarm.label)"
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "\(alarm.id)", content: content, trigger: trigger)
        userNotificationCenter.add(request, withCompletionHandler: nil)
    }
    
    static func removeNotification(alarmId: Int) {
        let id = "\(alarmId)"
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
        userNotificationCenter.removeDeliveredNotifications(withIdentifiers: [id])
    }
}
