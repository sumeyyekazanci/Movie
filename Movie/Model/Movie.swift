//
//  Movie.swift
//  Movie
//
//  Created by Sümeyye Kazancı on 4.06.2022.
//
//Search result list items
/* {
 "Search": [
     {
         "Title": "Starwars: Goretech",
         "Year": "2018",
         "imdbID": "tt9336300",
         "Type": "movie",
         "Poster": "https://m.media-amazon.com/images/M/MV5BNTI5OTBhMGYtNTZlNS00MjMzLTk5NTEtZDZkODM5YjYzYmE5XkEyXkFqcGdeQXVyMzU0OTU0MzY@._V1_SX300.jpg"
     }
 ]
 */

import Foundation

struct SearchList: Decodable {
    var Search: [SearchListItem]
}

struct SearchListItem: Decodable, Hashable {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    
    init() {
        title = ""
        year = ""
        imdbID = ""
        type = ""
        poster = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingsKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        imdbID = try container.decode(String.self, forKey: .imdbID)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
    }
    
    enum CodingsKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

//Movie details
/*
 {
     "Title": "Starwars: Goretech",
     "Year": "2018",
     "Rated": "N/A",
     "Released": "07 Dec 2018",
     "Runtime": "90 min",
     "Genre": "Action, Comedy, Sci-Fi",
     "Director": "Germán Magariños",
     "Writer": "Vic Cicuta, Germán Magariños",
     "Actors": "Vic Cicuta, Julieta Grimaldo, Fabian Moreno",
     "Plot": "N/A",
     "Language": "Spanish",
     "Country": "Argentina",
     "Awards": "N/A",
     "Poster": "https://m.media-amazon.com/images/M/MV5BNTI5OTBhMGYtNTZlNS00MjMzLTk5NTEtZDZkODM5YjYzYmE5XkEyXkFqcGdeQXVyMzU0OTU0MzY@._V1_SX300.jpg",
     "Ratings": [
         {
             "Source": "Internet Movie Database",
             "Value": "5.3/10"
         }
     ],
     "Metascore": "N/A",
     "imdbRating": "5.3",
     "imdbVotes": "30",
     "imdbID": "tt9336300",
     "Type": "movie",
     "DVD": "N/A",
     "BoxOffice": "N/A",
     "Production": "N/A",
     "Website": "N/A",
     "Response": "True"
 }
 */

struct Movie: Decodable, Hashable {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    var genre: String
    var runtime: String
    var director: String
    var actors: String
    var plot: String
    var released: String
    var rated: String
    var language: String
    
    init() {
        title = ""
        year = ""
        imdbID = ""
        type = ""
        poster = ""
        genre = ""
        runtime = ""
        director = ""
        actors = ""
        plot = ""
        released = ""
        rated = ""
        language = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingsKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        imdbID = try container.decode(String.self, forKey: .imdbID)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
        genre = try container.decode(String.self, forKey: .genre)
        runtime = try container.decode(String.self, forKey: .runtime)
        director = try container.decode(String.self, forKey: .director)
        actors = try container.decode(String.self, forKey: .actors)
        plot = try container.decode(String.self, forKey: .plot)
        released = try container.decode(String.self, forKey: .released)
        rated = try container.decode(String.self, forKey: .rated)
        language = try container.decode(String.self, forKey: .language)
    }
    
    enum MovieCodingsKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case genre = "Genre"
        case runtime = "Runtime"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case released = "Released"
        case rated = "Rated"
        case language = "Language"
    }
}

