//
//  OMDBClient.swift
//  EnsembleOMDB
//
//  Created by Monica on 2024-07-24.
//
import Foundation

class OMDBClient {
    let apiKey = "85795630"
    
    func percentEncode(string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func searchMovies(query: String, page: Int, completion: @escaping (OMDBResponse?) -> Void) {
        guard let encodedTitle = percentEncode(string: query) else {
            completion(nil)
            return
        }
        
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(encodedTitle)&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(OMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
