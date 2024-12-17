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
        let contentService = ContentService()
        
        ServiceLocator.shared.register(contentService, for: ContentService.self)
    }
    var body: some Scene {
        WindowGroup {
            let contentService = ServiceLocator.shared.resolve(ContentService.self)
            ContentView(contentService: contentService)
        }
    }
}
