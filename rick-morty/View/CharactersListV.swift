//
//  CharactersListView.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel = CharactersListViewModel()
    @State private var isShowingCharacters = false
    @State private var showNavigationBarTitle = false
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                        .scaleEffect(1.2)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                } else if isShowingCharacters {
                    List(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character)) {
                            if favoritesManager.isFavorite(characterId: character.id) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text(character.name)
                        }
                    }
                    .listStyle(.inset)
                } else {
                    VStack {
                        Text("Aby zobaczyć listę bohaterów, naciśnij przycisk powyżej.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {
                            viewModel.fetchCharacters()
                            isShowingCharacters = true
                            showNavigationBarTitle = true
                        }) {
                            Text("Wczytaj bohaterów")
                                .font(
                                    .system(size: 16)
                                    .weight(.heavy)
                                )
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                                .padding([.leading, .trailing])
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Lista bohaterów", displayMode: .inline)
        }
    }
}

