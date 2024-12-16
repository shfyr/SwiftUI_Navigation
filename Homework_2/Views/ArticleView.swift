//
//  ArticleView.swift
//  Homework_2
//
//  Created by Liza on 05.11.2024.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    @State private var didTapButton = false
    @State var isFavorite: Bool = false
    @State var contentType: ContentType
    @State var content: [Article]?
    @StateObject var contentService: ContentService
    var isLinkToAuthorPresented: Bool
    
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
