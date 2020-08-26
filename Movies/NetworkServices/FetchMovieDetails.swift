//
//  FetchMovieDetails.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 26.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxSwift

class FetchMovieDetails {
    static let shared = FetchMovieDetails()
    
    func loadMovie(id: Int) -> Observable<MovieDetails> {
        return Observable.create { (observer) -> Disposable in
            let request = Alamofire.AF.request("\(K.Urls.baseUrl)/\(id)", method: .get, parameters: NetforkUtilities.getParams(page: 1)).responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        let data = try response.result.get()
                        let dataJSON = JSON(data)
                        let id = dataJSON["id"].stringValue
                        let originalTitle = dataJSON["original_title"].stringValue
                        let overview = dataJSON["overview"].stringValue
                        let title = dataJSON["title"].stringValue
                        let video = dataJSON["video"].boolValue
                        let voteAverage = dataJSON["vote_average"].doubleValue
                        let backdropPath = K.Urls.imageUrl + dataJSON["backdrop_path"].stringValue
                        let posterPath = K.Urls.imageUrl + dataJSON["poster_path"].stringValue
                        let homepage = dataJSON["homepage"].stringValue
                        let movieDetails = MovieDetails(id: id, originalTitle: originalTitle, overview: overview, title: title, video: video, voteAverage: voteAverage, backdropPath: backdropPath, posterPath: posterPath, homepage: homepage)
                        observer.onNext(movieDetails)
                    } catch {
                        observer.onError(error)
                    }
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create(with: { request.cancel() })
        }
    }
}
