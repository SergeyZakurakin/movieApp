//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/31/24.
//

import Foundation
import SwiftUI


@MainActor
class MovieDetailsViewModel: ObservableObject {
    
    
    @Published var movieCreditsResults: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var profiles: [CastProfile] = []
    
    func movieCredits(for movieID: Int) async {
        
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let movieCredits = try JSONDecoder().decode(MovieCredits.self, from: data)
                self.movieCreditsResults = movieCredits
                self.cast = movieCredits.cast.sorted(by: {$0.order < $1.order})
                
            } catch {
                print(error.localizedDescription)
        }
    }
    
    func loadCastProfiles() async {
        
        do {
            for member in cast {
                let url = URL(string: "https://api.themoviedb.org/3/person/\(member.id)?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                profiles.append(profile)
//                profiles[member.order] = profile
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CastProfile: Decodable, Identifiable {
    
    let birthday: String
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoURL: URL? {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseUrl!.appending(path: profile_path ?? "")
    }
    
    
    struct CastImage: Decodable {
        let file_path: String
    }
}

struct MovieCredits: Decodable {
    
    let id: Int?
    let cast: [Cast]
    
    struct Cast: Decodable, Identifiable {
        let name: String
        let id: Int
        let character: String
        let order: Int
    }
}
