//
//  TrandingCardView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/21/24.
//

import SwiftUI

struct TrandingCardView: View {
    
    let trandingItem: Movie
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trandingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red:61/255, green:61/255, blue:88/255))
                    .frame(width: 340, height: 240)
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

