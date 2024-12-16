
struct Articles: Codable {
    var results: [Article]
}

//Hashable
struct Article: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var imageUrl: String
    var summary: String
    var newsSite: String
    var publishedAt: String

    static let example = Article(
        id: 12,
        title: "Webinar: Direct to Device Satellite Services – Register Now",
        imageUrl: "https://spacepolicyonline.com/wp-content/uploads/2024/03/ms-25-liftoff-300x168.png",
        summary: "The United States has become the first country to set ground rules for allowing satellite operators to use radio waves from terrestrial mobile partners to keep smartphone users connected beyond […]",
        newsSite: "SpaceNews",
        publishedAt: "2024-03-21T17:18:00Z"
    )
}

