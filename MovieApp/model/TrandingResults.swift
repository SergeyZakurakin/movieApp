//
//  TrandingResults.swift
//  MovieApp
//
//  Created by Sergey Zakurakin on 12/21/24.
//

import Foundation

struct TrandingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
