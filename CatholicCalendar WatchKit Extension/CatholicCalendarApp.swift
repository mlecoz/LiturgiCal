//
//  CatholicCalendarApp.swift
//  CatholicCalendar WatchKit Extension
//
//  Created by Marissa Le Coz on 4/21/21.
//

import SwiftUI

@main
struct CatholicCalendarApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(feastHandler: CurrentFeastHandler(feast: nil, feastService: LocalTestLiturgiCalService()))
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
