//
//  Homework_2App.swift
//  Homework_2
//
//  Created by Liza on 28.09.2024.
//

import SwiftUI

@main
struct Homework_2App: App {
    init() {
        // Register services on app startup
        ServiceLocator.shared.register(NetworkService(), for: NetworkService.self)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
