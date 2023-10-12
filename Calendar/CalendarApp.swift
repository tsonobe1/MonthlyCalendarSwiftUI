//
//  CalendarApp.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

@main
struct CalendarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Event.self)
    }
}
