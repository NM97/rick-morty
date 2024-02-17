//
//  EpisodeDetailsView.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode
    @StateObject var viewModel = EpisodeDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Text(episode.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Data emisji:")
                        .font(.headline)
                    Text("\(viewModel.formattedDate(for: episode.air_date))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Odcinek:")
                        .font(.headline)
                    Text("\(episode.episode)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Liczba bohaterów:")
                        .font(.headline)
                    Text("\(viewModel.charactersCount)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationBarTitle(episode.name, displayMode: .inline)
        .onAppear {
            viewModel.fetchCharactersCount(for: episode)
        }
    }
}
