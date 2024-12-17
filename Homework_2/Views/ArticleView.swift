//
//  ArticleView.swift
//  Homework_2
//
//  Created by Liza on 05.11.2024.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    let isLinkToAuthorPresented: Bool
    let contentType: ContentType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            HStack {
                if isLinkToAuthorPresented {
                    NavigationLink(value: article.newsSite) {
                        Text(article.newsSite)
                            .foregroundColor(.blue)
                            .underline()
                    }
                } else {
                    Text(article.newsSite)
                }
                
                Spacer()
                Text(article.publishedAt)
                    .foregroundColor(.gray)
            }
            
            AsyncImage(url: URL(string: article.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxHeight: 300)
            
            Text(article.summary)
                .foregroundColor(.black)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
        
        .navigationDestination(for: String.self) { newsSite in
            NewsView(
                viewModel: ArticlesViewModel(), // Inject a new ViewModel
                contentType: contentType,
                newsSite: newsSite
            )
        }
    }
}
