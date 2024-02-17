//
//  FavoritesManager.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    @Published private var favoriteCharacterIds: Set<Int> = []
    
    init() {
        loadFavoriteCharacterIds()
    }
    
    func toggleFavorite(characterId: Int) {
        if favoriteCharacterIds.contains(characterId) {
            favoriteCharacterIds.remove(characterId)
        } else {
            favoriteCharacterIds.insert(characterId)
        }
        saveFavoriteCharacterIds()
    }
    
    func isFavorite(characterId: Int) -> Bool {
        return favoriteCharacterIds.contains(characterId)
    }
    
    func loadFavoriteCharacterIds() {
        if let data = UserDefaults.standard.data(forKey: "favoriteCharacterIds"),
           let favoriteCharacterIds = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            self.favoriteCharacterIds = favoriteCharacterIds
        }
    }
    
    private func saveFavoriteCharacterIds() {
        if let data = try? JSONEncoder().encode(favoriteCharacterIds) {
            UserDefaults.standard.set(data, forKey: "favoriteCharacterIds")
        }
    }
}

