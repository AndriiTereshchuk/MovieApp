//
//  TableViewDataManager.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 22.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit

class TableViewMoviesManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    var films = [Film](){
        didSet {
            DispatchQueue.main.async {
                 self.table?.reloadData()
            }
        }
    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = films[indexPath.row].title
        return cell
    }
    
    func loadFilms() -> Void {
        if isLoading {
            return
        }
        isLoading = !isLoading
        let p = films.count/20 + 1
        FetchMovies.shared.loadMovies(category: category, page: p) { (films, error) in
            if error == nil {
                self.films =  self.films + films
            }
            self.isLoading = !self.isLoading
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
