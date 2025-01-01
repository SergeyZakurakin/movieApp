//
//  CastView.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 1/1/25.
//

import Foundation
import SwiftUI

struct CastView: View {
    
    let cast: CastProfile
    
    var body: some View {
        VStack {
            
            AsyncImage(url: cast.photoURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 120)
            }
            Text(cast.name)
//                .frame(width: 100)
//                .lineLimit(0)
        }
    }
}
