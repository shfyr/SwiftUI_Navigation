struct Articles: Codable {
    var results: [Article]
}

struct Article: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let imageUrl: String
    let summary: String
    let newsSite: String
    let publishedAt: String
    
    func dateFormatter(date: String) -> String {
        var finalDate = date
        if let i = finalDate.firstIndex(of: "Z") {
            finalDate.remove(at: i)
        }
        return finalDate.replacingOccurrences(of: "T", with: " ")
    }
}

