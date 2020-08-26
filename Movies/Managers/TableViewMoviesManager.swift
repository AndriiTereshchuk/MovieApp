//
//  TableViewDataManager.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 22.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class TableViewMoviesManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var films = [Film](){
        didSet {
            DispatchQueue.main.async {
                self.table?.reloadData()
            }
        }
    }
    let bagMovies = DisposeBag()
    var category = Category.popular
    var isLoading = false
    var table: UITableView?
    
    init(category: Category) {
        self.category = category
    }
    
    
}

extension TableViewMoviesManager {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TableViewMovieCell
        cell.title.text = films[indexPath.row].title
        cell.overview.text = films[indexPath.row].overview
        cell.posterImage.sd_setImage(with: URL(string: films[indexPath.row].poster), completed: nil)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("row: \(films[indexPath.row].id)")
        if let nc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            let movieController = MovieDetailsViewController.init()
            movieController.movieId = Int(films[indexPath.row].id)!
            nc.pushViewController(movieController, animated: true)
        }
    }
}


extension TableViewMoviesManager {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            loadFilms()
        }
    }
}


extension TableViewMoviesManager {
    func loadFilms() -> Void {
        if isLoading {
            return
        }
        isLoading = !isLoading
        let pageNum = films.count/20 + 1
        FetchMovies.shared.loadMovies(category: category, page: pageNum)
            .subscribe(
                onNext: { [weak self] movies in
                    // Store value
                    self?.films =  self!.films + movies
                    self?.isLoading = !(self?.isLoading ?? true)
                },
                onError: { [weak self] error in
                    self?.isLoading = !(self?.isLoading ?? true)
                }
        ).disposed(by: bagMovies)
    }
}
