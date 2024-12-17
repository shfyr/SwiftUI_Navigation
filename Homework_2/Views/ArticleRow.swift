//
//  ArticleRow.swift
//  Homework_2
//
//  Created by Liza on 18.10.2024.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    @State var isFavorite: Bool = false
    
    @State private var didTapButton = false
    
    init(article: Article, isFavorite: Bool = false) {
        self.article = article
        self.isFavorite = isFavorite
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 15)
            HStack {
                Text(article.newsSite)
                Spacer()
                Text(article.dateFormatter(date: article.publishedAt))
            }
            .foregroundStyle(.gray)
            AsyncImage(
                url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {}
                HStack(alignment: .top) {
                    Text(article.title)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                        .foregroundStyle(.black)

                    Spacer()

                    ZStack {
                        Button(action: {
                            isFavorite.toggle()
                            self.didTapButton = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.didTapButton = false
                            }
                        }, label: {
                            isFavorite 
                            ? Image(systemName: "star.fill")
                            : Image(systemName: "star")

                        })
                        .foregroundColor(.pink)
                            ButtonAnimation(isExpanded: $didTapButton)

                        }
                    }

                Text(article.summary)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(-1)
            Spacer()
                .frame(height: 15)
            }

        .padding(.horizontal, 20)
        .background(Color.white)
    }
}

struct ButtonAnimation: View {
    @Binding var isExpanded: Bool

    var body: some View {
        Image(systemName: "star")
            .frame(width: 30, height: 30)
            .foregroundColor(.pink)
            .opacity(isExpanded ? 0 : 0.5)
            .scaleEffect(isExpanded ? 4 : 1)
            .animation(isExpanded ? .easeOut(duration: 0.5) : nil)
    }
}
