//
//  Movie.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let total_results: Int
    public let total_pages: Int
    public let results: [Movie]
}

public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let original_title: String
    public let backdrop_path: String?
    public let poster_path: String?
    public let overview: String
    public let release_date: String
    public let vote_average: Double
    public let vote_count: Int
    public let tagline: String?
    public let genre_ids: [Int]?
    public let videos: MovieVideoResponse?
    public let credits: MovieCreditResponse?
  
    public let adult: Bool
    public let runtime: Int?
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdrop_path ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(vote_average * 10))%"
    }
    
    public var ratingText: String {
        let rating = Int(vote_average)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
    
}

//public struct MovieGenre: Codable {
//    let name:
//}

public struct MovieVideoResponse: Codable {
    public let results: [MovieVideo]
}

public struct MovieVideo: Codable {
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
public struct reviewsResponse: Codable {
    
    public let results: [MovieReview]
}

public struct MovieReview: Codable {
    public let id: String
    public let author: String
    public let content: String

}


public struct MovieCreditResponse: Codable {
    public let cast: [MovieCast]
    public let crew: [MovieCrew]
}

public struct MovieCast: Codable {
    public let character: String
    public let name: String
}

public struct MovieCrew: Codable {
    public let id: Int
    public let department: String
    public let job: String
    public let name: String
}
