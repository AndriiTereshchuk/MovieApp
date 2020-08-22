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
        
        popularManager.table = tableViewPopular.self
        topRatedMager.table = tableViewTopRated.self
        upcomingManager.table = tableViewUpcoming.self
        
        
        tableViewPopular.dataSource = popularManager.self
        tableViewPopular.delegate = popularManager.self
        
        tableViewTopRated.dataSource = topRatedMager.self
        tableViewTopRated.delegate = topRatedMager.self
        
        tableViewUpcoming.dataSource = upcomingManager.self
        tableViewUpcoming.delegate = upcomingManager.self
        
        
        popularManager.loadFilms()
        topRatedMager.loadFilms()
        upcomingManager.loadFilms()
    }
    
    func setUpSegmentControll() -> Void {
        view.backgroundColor = .white
        let screenWidth = UIScreen.main.bounds.width
        let navBarHeight = navigationController!.navigationBar.frame.height
        let xPostion: CGFloat = 10
        let yPostion: CGFloat = 2 * navBarHeight + 20
        let elementWidth: CGFloat = screenWidth - 20
        let elementHeight: CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        ////        // Make second segment selected
        mySegmentedControl.selectedSegmentIndex = 0
        ////        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = .yellow
        ////        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.white
        //
        mySegmentedControl.selectedSegmentTintColor = .white
        
        mySegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(mySegmentedControl)
        
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            tableViewPopular.isHidden = false
            tableViewUpcoming.isHidden = true
            tableViewTopRated.isHidden = true
        } else if index == 1 {
            tableViewPopular.isHidden = true
            tableViewUpcoming.isHidden = false
            tableViewTopRated.isHidden = true
        } else {
            tableViewPopular.isHidden = true
            tableViewUpcoming.isHidden = true
            tableViewTopRated.isHidden = false
        }
    }
    
    
    func prepareTabels() -> Void {
        tableViewPopular.backgroundColor = .red
        tableViewUpcoming.backgroundColor = .green
        tableViewTopRated.backgroundColor = .orange
        tableViewPopular.isHidden = false
        tableViewUpcoming.isHidden = true
        tableViewTopRated.isHidden = true
        tableViewPopular.tag = 0
        tableViewUpcoming.tag = 1
        tableViewTopRated.tag = 2
        tableViewPopular.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewUpcoming.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewTopRated.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupTableView(tableView: tableViewPopular)
        setupTableView(tableView: tableViewTopRated)
        setupTableView(tableView: tableViewUpcoming)
    }
    
    func setupTableView(tableView: UITableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: mySegmentedControl.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
