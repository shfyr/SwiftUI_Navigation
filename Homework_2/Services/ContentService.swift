import SwiftUI
import Combine

@MainActor
class ContentService: ObservableObject {
    @Published var canLoad = true
    @Published var offset = 0
    @Published var articles: [Article] = []

    private let urlString = "https://api.spaceflightnewsapi.net/v4/"

    func fetch(category: String, newsSite: String? = nil) async {
        guard canLoad else { return}

        canLoad = false
        let newsSiteLink = newsSiteFormatter(newsSite: newsSite)

        guard let url = URL(
            string: "\(urlString)\(category.lowercased())/?limit=10&\(newsSiteLink)offset=\(offset)"
        )
        else { print("Invalid URL")
            return
        }

        do {
            let items = try await loadItems(from: url)
            articles.append(contentsOf: items.results)

            offset += 10
            canLoad = true

        } catch {
            print (error.localizedDescription)
            canLoad = true
        }
    }

    private func loadItems(from url: URL) async throws -> Articles {
         let session = URLSession.shared
         let (data, _) = try await session.data(from: url)
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase

         return try decoder.decode(Articles.self, from: data)
     }

    private func newsSiteFormatter (newsSite: String? = nil) -> String {
        guard let newsSite = newsSite else { return "" }
        let newsSiteLink = "news_site=" + newsSite.replacingOccurrences(of: " ", with: "%20")
        return newsSiteLink + "&"
    }
}
