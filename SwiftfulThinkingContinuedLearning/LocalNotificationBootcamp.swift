//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 28/07/25.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: options) { (_, error) in
                if let error = error {
                    print("ERROR: \(error)")
                }
                self.getNotificationSettings()
            }
    }
    
    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                print("Permisos otorgados")
            case .denied:
                print("Permisos denegados")
            case .notDetermined:
                print("Permisos no determinados aún")
                case .ephemeral:
                    print("Permisos efímeros otorgados (temporales)")

                @unknown default:
                print("Estado de autorización desconocido")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was so easy!"
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(
//            timeInterval: 5,
//            repeats: false
//        )
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 22
//        dateComponents.minute = 37
//        dateComponents.weekday = 2
//        
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: dateComponents,
//            repeats: false
//        )
        // locaiton
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        let trigger = UNLocationNotificationTrigger(
            region: region,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter
            .current()
            .removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // quitar las notificcaiones ya entregadas para que no se acumulen en le dispositivo de la persona.
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack (spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear{
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
