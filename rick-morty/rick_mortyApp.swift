//
//  rick_mortyApp.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import SwiftUI

@main
struct rick_mortyApp: App {
    let favoritesManager = FavoritesManager()
    var body: some Scene {
        WindowGroup {
            CharactersListView()
                .environmentObject(favoritesManager)
        }
    }
}
