//
//  ArticleViewModel.swift
//  Homework_2
//
//  Created by Elizaveta on 17.12.2024.
//
import SwiftUI
import Combine

@MainActor
class ArticlesViewModel: ObservableObject {
    @Published var canLoad = true
    @Published var offset = 0
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkService = ServiceLocator.shared.resolve(NetworkService.self)) {
        self.networkService = networkService
    }

    func fetch(category: String, newsSite: String? = nil) async {
        guard canLoad else { return }
        canLoad = false

        do {
            let fetchedArticles = try await networkService.fetchArticles(
                category: category,
                newsSite: newsSite,
                offset: offset
            )
            articles.append(contentsOf: fetchedArticles.results)
            offset += 10
        } catch {
            print("Error fetching articles: \(error.localizedDescription)")
        }

        canLoad = true
    }
}
