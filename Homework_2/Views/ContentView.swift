//
//  ContentView.swift
//  Homework_2
//
//  Created by Liza on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: ContentType = .articles
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ForEach(ContentType.allCases, id: \.self) { tab in
                NavigationStack {
                    // Use DI to initialize the ViewModel
                    NewsView(viewModel: ArticlesViewModel(), contentType: tab)
                }
                .tabItem {
                    Label(tab.rawValue, systemImage: "newspaper")
                }
                .tag(tab)
            }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag("favorites")
        }
    }
}

