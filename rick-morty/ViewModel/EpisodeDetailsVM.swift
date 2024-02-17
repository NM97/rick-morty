//
//  EpisodeDetailsViewModel.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

class EpisodeDetailsViewModel: ObservableObject {
    @Published var charactersCount: Int = 0
    @Published var errorMessage: String?
    
    func fetchCharactersCount(for episode: Episode) {
        Task {
            do {
                let count = try await APIClient.fetchCharactersCount(from: episode.id)
                
                DispatchQueue.main.async {
                    self.charactersCount = count
                    self.errorMessage = nil
                }
            } catch {
                self.errorMessage = "Wystąpił błąd podczas zliczania ilości bohaterów występujących w odcinku. (\(error))"
                print("Error: \(error)")
            }
        }
    }
    
    func formattedDate(for dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "d MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "pl_PL")
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}
