//
//  ContentView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MovieDBViewModel()
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
                                    TrandingCardView(trandingItem: trandingItem)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                } else {
                    ForEach(viewModel.searchResults) { item in
                        Text(item.title)
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
        }
        .ignoresSafeArea()
    }
        
}

#Preview {
    ContentView()
}
