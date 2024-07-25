//
//  MovieListViewModel.swift
//  EnsembleOMDB
//
//  Created by Monica on 2024-07-24.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var query: String = "" {
        didSet {
            resetSearch()
            searchMovies(page: 1)
        }
    }
    
    private var currentPage: Int = 1
    var totalResults: Int = 0
    private let omdbClient = OMDBClient()
    
    func searchMovies(page: Int) {
        guard !query.isEmpty else {
            self.movies = []
            return
        }
        isLoading = true
        omdbClient.searchMovies(query: query, page: page) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let response = response {
                    if page == 1 {
                        self.movies = response.search
                    } else {
                        self.movies.append(contentsOf: response.search)
                    }
                    self.totalResults = Int(response.totalResults) ?? 0
                    self.currentPage = page
                }
                self.isLoading = false
            }
        }
    }
    
    func loadMoreMovies() {
        guard !isLoading, movies.count < totalResults else {
            return
        }
        let nextPage = currentPage + 1
        searchMovies(page: nextPage)
    }
    
    func resetSearch() {
        self.movies = []
        self.currentPage = 1
        self.totalResults = 0
    }
}
