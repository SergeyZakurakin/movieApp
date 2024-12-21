//
//  ContentView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        VStack {
            if viewModel.tranding.isEmpty {
                Text("No Results")
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.tranding) { trandingItem in
                            Text(trandingItem.title)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadTranding()
        }
    }
}

struct TrandingCardView: View {
    
    let trandingItem: TrandingItem
    var body: some View {
        ZStack {
            AsyncImage(url: trandingItem.poster_path) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            VStack {
                HStack {
                    Text(trandingItem.title)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
            }
        }
    }
}


@MainActor
class MovieDBViewModel: ObservableObject {
    
    @Published var tranding: [TrandingItem] = []
    static let apiKey = "72619582d27fe03744c5b19e8b2e9920"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjYxOTU4MmQyN2ZlMDM3NDRjNWIxOWU4YjJlOTkyMCIsIm5iZiI6MTczNDc0MzI4MC4xMzUsInN1YiI6IjY3NjYxNGYwYjY3ZTQ1NDcyNTVlMGM2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rwv4fbA_ZkTEMgpt8bAwxqDZsUNYED9xAkKAE3ZQLxc"
    
    //https://api.themoviedb.org/3/movie/550?api_key=72619582d27fe03744c5b19e8b2e9920
    
    //https://api.themoviedb.org/3/trending/movie/day?api_key=72619582d27fe03744c5b19e8b2e9920
    
    
    
    func loadTranding() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
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
}

struct TrandingResults: Decodable {
    let page: Int
    let results: [TrandingItem]
    let total_pages: Int
    let total_results: Int
}

struct TrandingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}


#Preview {
    ContentView()
}
