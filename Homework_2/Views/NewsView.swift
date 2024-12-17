//
//  NewsView.swift
//  Homework_2
//
//  Created by Elizaveta on 16.12.2024.
//
import SwiftUI

enum NavigationTarget: Hashable {
    case articleView(article: Article, isLinkToAuthorPresented: Bool)
}

struct NewsView: View {
    @StateObject private var viewModel: ArticlesViewModel
    let contentType: ContentType
    let newsSite: String?

    init(viewModel: ArticlesViewModel, contentType: ContentType, newsSite: String? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.contentType = contentType
        self.newsSite = newsSite
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 1) {
                ForEach(viewModel.articles, id: \.id) { article in
                    NavigationLink(
                        value: NavigationTarget.articleView(
                            article: article,
                            isLinkToAuthorPresented: newsSite == nil
                        )
                    ) {
                        ArticleRow(
                            article: article
                        )
                            .onAppear {
                                Task {
                                    if viewModel.articles.isLastItem(article) {
                                        await viewModel.fetch(category: contentType.rawValue, newsSite: newsSite)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            Task {
                if viewModel.articles.isEmpty {
                    await viewModel.fetch(category: contentType.rawValue, newsSite: newsSite)
                }
            }
        }
        .navigationTitle(contentType.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: NavigationTarget.self) { target in
            switch target {
            case .articleView(let article, let isLinkToAuthorPresented):
                ArticleView(
                    article: article,
                    isLinkToAuthorPresented: isLinkToAuthorPresented,
                    contentType: contentType
                )
            }
        }
    }
}

