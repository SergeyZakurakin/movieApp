//
//  MovieDiscoverViewModel.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/21/24.
//

import Foundation

@MainActor
class MovieDiscoverViewModel: ObservableObject {
    
    @Published var tranding: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var movieCredits: MovieCredits?
    
    
    static let apiKey = "72619582d27fe03744c5b19e8b2e9920"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjYxOTU4MmQyN2ZlMDM3NDRjNWIxOWU4YjJlOTkyMCIsIm5iZiI6MTczNDc0MzI4MC4xMzUsInN1YiI6IjY3NjYxNGYwYjY3ZTQ1NDcyNTVlMGM2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rwv4fbA_ZkTEMgpt8bAwxqDZsUNYED9xAkKAE3ZQLxc"
    
    //https://api.themoviedb.org/3/movie/550?api_key=72619582d27fe03744c5b19e8b2e9920
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=72619582d27fe03744c5b19e8b2e9920
    
    
    
    func loadTranding() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
//                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
//                    print("Success")
//                }
                
                let trandingResults = try JSONDecoder().decode(TrandingResults.self, from: data)
                tranding = trandingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(term)")!
          
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
//                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
//                    print("Success")
//                }
                
                let trandingResults = try JSONDecoder().decode(TrandingResults.self, from: data)
                searchResults = trandingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    

    
}

