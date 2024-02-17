//
//  CharactersListViewModel.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

class CharactersListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var favoriteCharacterIds: [Int] = []
    
    init() {
        fetchCharacters()
       }
    
    func fetchCharacters() {
        isLoading = true
        Task {
            do {
                let characters = try await APIClient.fetchCharacters()
                DispatchQueue.main.async {
                    self.characters = characters
                    self.isLoading = false
                    self.errorMessage = nil
                }
            } catch {
                self.errorMessage = "Wystąpił błąd podczas pobierania listy bohaterów. (\(error))"
                print("Error: \(error)")
            }
        }
    }
}

