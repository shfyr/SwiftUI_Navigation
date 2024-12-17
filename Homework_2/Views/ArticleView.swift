//
//  ArticleView.swift
//  Homework_2
//
//  Created by Liza on 05.11.2024.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    var isLinkToAuthorPresented: Bool
    
    @StateObject private var contentService: ContentService = ServiceLocator.shared.resolve(ContentService.self)
    @State var contentType: ContentType
    @State var content: [Article]?
    
    init(
        article: Article,
        isLinkToAuthorPresented: Bool,
        contentService: ContentService,
        contentType: ContentType,
        content: [Article]? = nil
    ) {
        _contentService = StateObject(wrappedValue: contentService)
        self.article = article
        self.isLinkToAuthorPresented = isLinkToAuthorPresented
        self.contentType = contentType
        self.content = content
    }
   
    
    var body: some View {
        VStack {
            Text(article.title)
                .fontWeight(.bold)
                .font(.system(size: 22))
                .foregroundStyle(.black)
            Spacer()
                .frame(height: 15)
            HStack {
                if isLinkToAuthorPresented {
                    NavigationLink(value: article.newsSite) {
                        Text(article.newsSite)
                            .foregroundColor(.blue)
                    }
                } else {
                    Text(article.newsSite)
                }
                Spacer()
                Text(article.publishedAt)
            }
            .foregroundStyle(.gray)
            AsyncImage(
                url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {}
            
            Text(article.summary)
                .foregroundColor(.black)
                .padding(-1)
            
            Spacer()
        }
        
        .navigationDestination(for: String.self) { newsSite in
            if isLinkToAuthorPresented {
                NewsView(
                    contentService: contentService,
                    contentType: contentType,
                    newsSite: article.newsSite
                )
            }
        }
        .padding(.horizontal, 20)
        .background(Color.white)
    }
}
