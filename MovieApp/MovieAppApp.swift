//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/20/24.
//

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                
                DiscoverView()
                    .tabItem {
                        Image(systemName: "popcorn")}
                Text("Favorite")
                    .tabItem {
                        Image(systemName: "heart.fill")}
                Text("Tickets")
                    .tabItem {
                        Image(systemName: "bookmark.fill")}
                
                
            }
        }
    }
}
