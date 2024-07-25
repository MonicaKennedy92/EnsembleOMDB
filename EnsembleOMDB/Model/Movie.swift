//
//  Movie.swift
//  EnsembleOMDB
//
//  Created by Monica on 2024-07-24.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id = UUID()
    let title: String
    let year: String
    let poster: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID
    }
}

struct OMDBResponse: Codable {
    let search: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}
