//
//  CharacterDetailsView.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    @StateObject var viewModel = CharacterDetailsViewModel()
    @State private var isFavorite: Bool = false
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    
    let statusTranslations: [String: [String: String]] = [
        "Alive": ["Male": "Żywy", "Female": "Żywa", "Genderless": "Żywe", "unknown": "Nieznany"],
        "Dead": ["Male": "Martwy", "Female": "Martwa", "Genderless": "Martwe", "unknown": "Nieznany"],
        "unknown": ["Male": "Nieznany", "Female": "Nieznany", "Genderless": "Nieznany", "unknown": "Nieznany"]
    ]
    
    let genderTranslations: [String: String] = [
        "Male": "Mężczyzna",
        "Female": "Kobieta",
        "Genderless": "Bezpłciowy",
        "unknown": "Nieznana"
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                HStack{
                    URLImage(url: character.image)
                        .frame(maxWidth: 150, maxHeight: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    VStack(alignment: .leading, spacing: 5){
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.bold)
                        let statusTranslation = statusTranslations[character.status]?[character.gender] ?? character.status
                        Text("Status: \(statusTranslation)")
                        Text("Płeć: \(genderTranslations[character.gender] ?? character.gender)")
                        Text("Pochodzenie: \(character.origin.name)")
                        Text("Lokalizacja: \(character.location.name)")
                        Text("Lokalizacja: \(character.id)")
                    }
                }
                Divider()
                Text("Odcinki:")
                    .font(.headline)
                ForEach(viewModel.episodes) { episode in
                    NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                        HStack {
                            Text("Odcinek")
                                .fontWeight(.bold)
                            Text("\(episode.episode)")
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationBarTitle(character.name, displayMode: .inline)
        .onAppear {
            viewModel.fetchEpisodes(for: character)
            isFavorite = favoritesManager.isFavorite(characterId: character.id)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isFavorite.toggle()
                    favoritesManager.toggleFavorite(characterId: character.id)
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
            }
        }
    }
}
