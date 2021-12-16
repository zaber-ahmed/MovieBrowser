//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Zaber Ahmed on 11/12/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let page: Int?
    let results: [MovieModel]?
    let total_pages: Int?
    let total_results: Int?
}

struct MovieModel: Codable {    
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
