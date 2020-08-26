//
//  RootViewController.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 21.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    let mySegmentedControl = UISegmentedControl (items: K.segmentControllTitles)
    let nib = UINib.init(nibName: K.nibName, bundle: nil)
    
    let tableViewPopular = UITableView()
    let tableViewTopRated = UITableView()
    let tableViewUpcoming = UITableView()
    
    let popularManager = TableViewMoviesManager(category: .popular)
    let topRatedMager = TableViewMoviesManager(category: .topRated)
    let upcomingManager = TableViewMoviesManager(category: .upcoming)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentControll()
        prepareTabels()
        setUpTableViewManager(tableView: tableViewPopular, moviesManager: popularManager)
        setUpTableViewManager(tableView: tableViewTopRated, moviesManager: topRatedMager)
        setUpTableViewManager(tableView: tableViewUpcoming, moviesManager: upcomingManager)
        navigationItem.title = K.NavBarTitles.movies
    }
    
}
