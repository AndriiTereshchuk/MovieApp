//
//  MovieDetailsManager.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 26.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

protocol MovieDetailsDelegate {
    func setUpCoverImage(url: String)
}

class MovieDetailsManager {
    let bagMovie = DisposeBag()
    var data = [String: MovieDetails]()
    var delegate: MovieDetailsDelegate?
    var error: Error?
    
    func loadMovieDetails(id: Int) -> Void {
        if data["\(id)"] != nil {
            runDelegates(id: id)
        } else {
            FetchMovieDetails.shared.loadMovie(id: id).subscribe(
                onNext: { [weak self] movie in
                    self?.data["\(id)"] = movie
                    self?.runDelegates(id: id)
                },
                onError: { [weak self] error in
                    self?.error = error
                }
            ).disposed(by: bagMovie)
        }
    }
    
    func runDelegates(id: Int) -> Void {
        if let movie = data["\(id)"] {
            delegate?.setUpCoverImage(url: movie.backdropPath)
        }
    }
}
