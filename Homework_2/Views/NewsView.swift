//
//  NewsView.swift
//  Homework_2
//
//  Created by Elizaveta on 16.12.2024.
//
import SwiftUI

private enum NavigationTarget: Hashable {
    case articleView(article: Article, isLinkToAuthorPresented: Bool)
}

struct NewsView: View {
    @StateObject private var contentService: ContentService
    @State var contentType: ContentType
    @State var content: [Article]?
    @State var newsSite: String?
    
    init(
        contentService: ContentService,
        contentType: ContentType,
        content: [Article]? = nil,
        newsSite: String? = nil
    ) {
        _contentService = StateObject(wrappedValue: contentService)
        self.contentType = contentType
        self.content = content
        self.newsSite = newsSite
    }

    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 1) {
                ForEach(contentService.articles) { article in
                    NavigationLink(
                        value: configureNavigationLink(for: article)
                    ) {
                        ArticleRow(article: article)
                            .onAppear {
                                Task {
                                    if contentService.articles.isLastItem(article) {
                                        await contentService.fetch(category: contentType.rawValue, newsSite: newsSite)
                                    }
                                }
                            }
                    }
                }
            }
            .background(Color.gray)
        }
        .navigationDestination(for: NavigationTarget.self) { target in
            switch target {
            case .articleView(let article, let isLinkToAuthorPresented):
                ArticleView(
                    article: article,
                    isLinkToAuthorPresented: isLinkToAuthorPresented,
                    contentService: contentService,
                    contentType: contentType
                )
                .onAppear {
                    Task {
                        await contentService.fetch(category: contentType.rawValue, newsSite: newsSite)
                    }
                }
            }
            
        }
        .onAppear {
            Task {
                contentService.offset = 0
                await contentService.fetch(category: contentType.rawValue, newsSite: newsSite)
            }
        }
        
        .navigationTitle(getTitle())
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getTitle() -> String {
        guard newsSite != nil else { return "" }
        return "\(contentType) by \(newsSite ?? "")"
    }
    
    private func configureNavigationLink(for article: Article) -> NavigationTarget {
        newsSite == nil
        ? NavigationTarget.articleView(
            article: article,
            isLinkToAuthorPresented: true
        )
        : NavigationTarget.articleView(
            article: article,
            isLinkToAuthorPresented: false
        )
    }
}

