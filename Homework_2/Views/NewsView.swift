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
    @StateObject var contentService: ContentService
    @State var contentType: ContentType
    @State var content: [Article]?
    @State var newsSite: String?
    @State private var myVar = false
    @State private var navigationValue: NavigationTarget? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 1) {
                ForEach(contentService.articles) { article in
                    NavigationLink(
                        value: newsSite == nil
                        ? NavigationTarget.articleView(
                            article: article,
                            isLinkToAuthorPresented: true
                        )
                        : NavigationTarget.articleView(
                            article: article,
                            isLinkToAuthorPresented: false
                        )
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
                        contentType: contentType,
                        contentService: contentService,
                        isLinkToAuthorPresented: isLinkToAuthorPresented
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
}

