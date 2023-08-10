//
//  ViewController.swift
//  ClockDemo
//
//  Created by imac-2437 on 2023/8/9.
//

import UserNotifications
import RealmSwift

func createNotification() {
    let realm = try! Realm()
    let timeDatabase = realm.objects(iteamTable.self)
    
    if timeDatabase.count > 0 {
        for i in 0...timeDatabase.count - 1 {
            
            let content = UNMutableNotificationContent()
            
            content.title = timeDatabase[i].Title
            content.subtitle = "時間到"
            content.body = "現在"
            content.badge = 1
            content.sound = UNNotificationSound.default
//            let formatter = DateFormatter()
//            let dateTimeString = formatter.string(from: timeDatabase[i].Totaltime)
//            let components = dateTimeString.components(separatedBy: ":")
//            print("b\(components)")
//            let hour24 = Int(components[0])
//            let minutes24 = Int(components[1])
            let calendar = Calendar.current
            let hour24 = calendar.component(.hour, from: timeDatabase[i].Totaltime)
            let minutes24 = calendar.component(.minute, from: timeDatabase[i].Totaltime)
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: .init(hour: hour24, minute: minutes24), repeats: false)
            let request = UNNotificationRequest(identifier: "\(timeDatabase[i].uuid)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
    }
}

func deleteNotification(UuidIdentifier: ObjectId){
    let notificationIdentifier = "\(UuidIdentifier)"
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    
}
    
    
