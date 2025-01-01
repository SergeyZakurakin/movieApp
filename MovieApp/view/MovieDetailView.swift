//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/29/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = MovieDetailsViewModel()
    let movie: Movie
    let headerline: CGFloat = 400
    
   
    
    var body: some View {
        ZStack {
            
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: headerline)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }
           
            
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: headerline)
                    HStack {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        // retings here
                    }
                    HStack {
                        // genre tags here
                        
                        // runing time
                    }
                    HStack {
                        Text("About film")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer()
                        // see all button
                    }
                    
                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Text("Cast & Crew")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer()
                        // see all button
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.profiles) { cast in
                                
                                CastView(cast: cast)
                            }
                        }
                    }
                }
                .padding()
            }
            
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
        }
        .background(Color(red:61/255, green:61/255, blue:88/255)
            .ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .imageScale(.large)
        .foregroundStyle(.white)
        .fontWeight(.bold)
        .task {
            await viewModel.movieCredits(for: movie.id)
            await viewModel.loadCastProfiles()
        }
        
    }
}

#Preview {
    MovieDetailView(movie: .preview)
}



