//
//  DiscoverView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/20/24.
//

import SwiftUI

struct DiscoverView: View {
    
    @StateObject var viewModel = MovieDiscoverViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if searchText.isEmpty {
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
                                    NavigationLink {
                                        MovieDetailView(movie: trandingItem)
                                        
                                    } label: {
                                            TrandingCardView(trandingItem: trandingItem)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                } else {
                    LazyVStack{
                        ForEach(viewModel.searchResults) { item in
                            HStack {
                                AsyncImage(url: item.backdropURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 120)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 80, height: 120)
                                }
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundStyle(.yellow)
                                        Text("\(item.vote_average.formatted())")
                                        Spacer()
                                    }
                                    .foregroundStyle(.yellow)
                                    .fontWeight(.heavy)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(red:61/255, green:61/255, blue:88/255))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                        }
                    }
                    
                }
            }
            .background(Color(red:39/255, green:40/255, blue: 59/255))
        }
        
       
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                viewModel.search(term: newValue)
            }
        }
        
        .onAppear {
            viewModel.loadTranding()
            searchText = ""
        }
        .ignoresSafeArea()
    }
        
}

#Preview {
    DiscoverView()
}
