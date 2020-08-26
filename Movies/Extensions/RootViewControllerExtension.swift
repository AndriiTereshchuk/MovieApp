//
//  RootViewControllerExtension.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 22.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit

extension RootViewController {
    var segmentControllHeight: CGFloat {
        get {
            return 30
        }
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
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mySegmentedControl.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func setUpTableViewManager(tableView: UITableView, moviesManager: TableViewMoviesManager) -> Void {
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        moviesManager.table = tableView.self
        tableView.dataSource = moviesManager.self
        tableView.delegate = moviesManager.self
        tableView.rowHeight = 240.0
        moviesManager.loadFilms()
    }
    
    func setUpSegmentControll() -> Void {
        view.backgroundColor = .white
        let screenWidth = UIScreen.main.bounds.width
        let navBarHeight = navigationController!.navigationBar.frame.height
        var statusBarHeight = CGFloat(0)
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? CGFloat(0)) + 10
            
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height + 10
        }
        let xPostion: CGFloat = 10
        let yPostion: CGFloat = navBarHeight + statusBarHeight
        let elementWidth: CGFloat = screenWidth - 20
        let elementHeight: CGFloat = segmentControllHeight
        
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
}
