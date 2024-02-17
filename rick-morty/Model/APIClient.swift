//
//  APIClient.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case invalidData
}

class APIClient {
    static let baseURL = "https://rickandmortyapi.com/api"
    
    static func fetchCharacters() async throws -> [Character] {
        var allCharacters: [Character] = []
        var nextPageURL = URL(string: "\(baseURL)/character")
        
        while let url = nextPageURL {
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            guard let results = json["results"] as? [[String: Any]] else {
                throw APIError.invalidData
            }
            
            let characters = try results.map { result in
                try JSONDecoder().decode(Character.self, from: JSONSerialization.data(withJSONObject: result, options: []))
            }
            
            allCharacters.append(contentsOf: characters)
            
            guard let info = json["info"] as? [String: Any], let next = info["next"] as? String else {
                nextPageURL = nil
                continue
            }
            
            nextPageURL = URL(string: next)
        }
        
        return allCharacters
    }
    
    static func fetchCharactersCount(from eID: Int) async throws -> Int {
        guard let url = URL(string: "\(baseURL)/episode/\(eID)") else {
            throw APIError.invalidURL
        }
        
        var count = 0
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw APIError.invalidData
        }
        
        if let characters = json["characters"] as? [Any] {
            count = characters.count
        }
        
        return count
    }
    
    static func fetchEpisode(from url: String) async throws -> Episode {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Episode.self, from: data)
    }
}
