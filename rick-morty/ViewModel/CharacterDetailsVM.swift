//
//  EpisodeDetailsViewModel.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    @Published var errorMessage: String?
    
    func fetchEpisodes(for character: Character) {
        Task {
            do {
                var episodes: [Episode] = []
                
                for episodeURL in character.episode {
                    let episode = try await APIClient.fetchEpisode(from: episodeURL)
                    episodes.append(episode)
                }
                
                DispatchQueue.main.async {
                    self.episodes = episodes
                    self.errorMessage = nil
                }
            } catch {
                self.errorMessage = "Wystąpił błąd podczas pobierania listy odcinków. (\(error))"
                print("Error: \(error)")
            }
        }
    }
}


