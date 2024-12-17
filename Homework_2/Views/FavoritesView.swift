//
//  FavoritesView.swift
//  Homework_2
//
//  Created by Elizaveta on 17.12.2024.
//
import SwiftUI

// Test View for EventBus to make any sense
struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteArticles, id: \.id) { article in
                    ArticleRow(article: article)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
