//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Andrii Tereshchuk on 25.08.2020.
//  Copyright © 2020 Andrii Tereshchuk. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController, MovieDetailsDelegate {
    
    
    let stackView = UIStackView()
    var movieId: Int? = nil
    var movieDetailsManager = MovieDetailsManager()
    var image = UIImageView()
    
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = "Scroll Top"
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Scroll Bottom"
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let scroll = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsManager.delegate = self
        if let id = movieId {
            movieDetailsManager.loadMovieDetails(id: id)
        }
        view.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .blue
        view.addSubview(scroll);
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func setUpCoverImage(url: String) {
        image.sd_setImage(with: URL(string: url), completed: nil)
        scroll.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: scroll.topAnchor),
            image.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            image.heightAnchor.constraint(equalToConstant: 281.0)
        ])
        image.contentMode = .scaleToFill
        
    }
    
}
