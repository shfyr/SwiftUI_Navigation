//
//  ContentView.swift
//  Homework_2
//
//  Created by Liza on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection: ContentType = .articles
    @StateObject var contentService = ContentService()

    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(ContentType.allCases, id: \.rawValue) { tab in
                NavigationStack {
                    NewsView(contentService: contentService, contentType: tab)
                }
                    .tabItem {
                        Label(tab.rawValue, systemImage: "heart")
                    }
                    .tag(tab)
            }
        }
    }
}
