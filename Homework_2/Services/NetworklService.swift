import SwiftUI
import Combine

struct NetworkService {
    private let baseURL = "https://api.spaceflightnewsapi.net/v4/"
    
    func fetchArticles(category: String, newsSite: String?, offset: Int) async throws -> Articles {
        let url = try constructURL(category: category, newsSite: newsSite, offset: offset)
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Articles.self, from: data)
    }
    
    private func constructURL(category: String, newsSite: String?, offset: Int) throws -> URL {
        let newsSiteLink = newsSiteFormatter(newsSite: newsSite)
        let urlString = "\(baseURL)\(category.lowercased())/?limit=10&\(newsSiteLink)offset=\(offset)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    private func newsSiteFormatter(newsSite: String?) -> String {
        guard let newsSite = newsSite else { return "" }
        let formatted = "news_site=" + newsSite.replacingOccurrences(of: " ", with: "%20")
        return "\(formatted)&"
    }
}
