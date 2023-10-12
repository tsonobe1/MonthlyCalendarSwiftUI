//
//  CalenderApp.swift
//  Calender
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

@main
struct CalenderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Event.self)
    }
}
