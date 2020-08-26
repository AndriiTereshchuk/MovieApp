//
//  FetchMovies.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 22.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxSwift


enum Category: String {
    case popular, topRated, upcoming
    
    var url: String {
        switch self {
        case .popular:
            return K.Urls.popular
        case .topRated:
            return K.Urls.topRated
        case .upcoming:
            return K.Urls.upcoming
        }
    }
}


class FetchMovies {
    static let shared = FetchMovies()
    
    func loadMovies(category: Category, page: Int = 1) -> Observable<[Film]> {
        return Observable.create { (observer) -> Disposable in
            let requestReference =  Alamofire.AF.request("\(K.Urls.baseUrl)\(category.url)", method: .get, parameters: NetforkUtilities.getParams(page: page)).validate().responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        let data = try response.result.get()
                        let dataJSON = JSON(data)
                        var films = [Film]();
                        let results = dataJSON["results"].arrayValue
                        
                        for filmJSON in results {
                            let id = filmJSON["id"].stringValue
                            let title = filmJSON["title"].stringValue
                            let overview = filmJSON["overview"].stringValue
                            let poster = K.Urls.imageUrl + filmJSON["poster_path"].stringValue
                            let film = Film(id: id, title: title, overview: overview, poster: poster)
                            films.append(film)
                        }
                        observer.onNext(films)
                    } catch {
                       observer.onError(error)
                    }
                case let .failure(error):
                   observer.onError(error)
                }
            }
        
            return Disposables.create(with: { requestReference.cancel() })
        }
    }
}
