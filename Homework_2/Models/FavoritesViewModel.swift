import Combine
import SwiftUI

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favoriteArticles: [Article] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Подписка на события EventBus
        EventBus.shared.favoriteToggled
            .sink { [weak self] article in
                guard let self = self else { return }
                if self.favoriteArticles.contains(article) {
                    self.favoriteArticles.removeAll { $0.id == article.id }
                } else {
                    self.favoriteArticles.append(article)
                }
            }
            .store(in: &cancellables)
    }
}
