//
//  Constants.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 21.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

//https://api.themoviedb.org/3/movie/upcoming?api_key=76984f3d864f02cb288e53d24f6e7d6b&language=ru-Ru&page=2

struct K {
    static let segmentControllTitles = ["Popular", "Top Rated", "Upcoming"]
    static let cellIdentifier = "cellIdentifier"
    static let nibName = "TableViewMovieCell"
    static let apiKey = "4d71d99e3f88ee67b30bfbd36ce8899e"
    struct Urls {
        static let baseUrl = "https://api.themoviedb.org/3/movie"
        static let imageUrl = "https://image.tmdb.org/t/p/w500"
        static let topRated = "/top_rated"
        static let popular = "/popular"
        static let upcoming = "/upcoming"
    }
    struct NavBarTitles {
        static let movies = "Movies"
    }
    
}
