//
//  MovieDetailsViewController.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MovieDetailsViewController: UIViewController {
    
    var movie: MovieData?
    let apiService = APIService()
    let apiServiceForCorData = APIServiceForCorData()
    let imageService = ImageService()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    func setUpView() {
        self.title = "Movie Details"
        titleLabel.text = movie?.title
        yearLabel.text = "Release year:  \(String(movie!.releaseYear))"
        ratingLabel.text = "Rating:  \(String(movie!.ratingAsString))"
        
        if movie?.genre.count != 0 {
            var str = "Genre: "
            for item in (movie?.genre)!{
                str += " \(item),"
                
            }
            self.genreLabel.text = str
        }
  
        guard let movieImageUrl = movie?.image else {
            return
        }
        
        imageService.getImage(from: movieImageUrl) { (image, error) in
            if let image = image {
                self.moviePoster.image = image
            }
        }
    }

    
    func moveToSegue(movie: MovieData) {
        self.movie = movie
    }
}







//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.title = "Movie Details"
//        titleLabel.text = movie?.title
//        yearLabel.text = "Release year:  \(String(movie!.releaseYear))"
//        ratingLabel.text = "Rating:  \(String(movie!.ratingAsString))"
//        genreArray()
//        setUpImageFromImageUrl()
//    }
//
//    func genreArray() {
//        if movie?.genre.count != 0 {
//            var str = "Genre: "
//            for item in (movie?.genre)!{
//                str += " \(item),"
//
//            }
//            self.genreLabel.text = str
//        }
//    }
//
//    func setUpImageFromImageUrl() {
//        guard let movieImageUrl = movie?.image else {
//            return
//        }
//
//        imageService.getImage(from: movieImageUrl) { (image, error) in
//            if let image = image {
//                self.moviePoster.image = image
//            }
//        }
//    }
//
//    func moveToSegue(movie: MovieData) {
//        self.movie = movie
//    }
//
//}
