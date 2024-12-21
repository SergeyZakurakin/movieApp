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
        ScrollView {
            if viewModel.tranding.isEmpty {
                Text("No Results")
            } else {
                HStack {
                    Text("Tranding")
                        .font(.title)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.tranding) { trandingItem in
                            TrandingCardView(trandingItem: trandingItem)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .background(Color(red:39/255, green:40/255, blue: 59/255).ignoresSafeArea())
        .padding()
        .onAppear {
            viewModel.loadTranding()
        }
    }
}

struct TrandingCardView: View {
    
    let trandingItem: TrandingItem
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trandingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 200)
            } placeholder: {
                Rectangle().fill(Color(red:61/255, green:61/255, blue:88/255))
                    .frame(width: 340, height: 200)
                ProgressView()
            }
            VStack {
                HStack {
                    Text(trandingItem.title)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundStyle(.yellow)
                    Text("\(trandingItem.vote_average.formatted())")
                    Spacer()
                }
                .foregroundStyle(.yellow)
                .fontWeight(.heavy)
                
            }
            .padding()
            .background(Color(red:61/255, green:61/255, blue:88/255))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
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
    let backdrop_path: String
    
    var backdropURL: URL {
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w300")!
        return baseUrl.appending(path: backdrop_path)
    }
}


#Preview {
    ContentView()
}
