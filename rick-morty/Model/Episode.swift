//
//  EpisodeModel.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String] // Lista URL-ów postaci występujących w odcinku
    let url: String
    let created: String
}
