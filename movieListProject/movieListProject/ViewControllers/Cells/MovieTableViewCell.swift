//
//  MovieTableViewCell.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movie: MovieData?
    var imageService = ImageService()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension MovieTableViewCell {
    func setInfo(movie: MovieData) {
        titleLabel.text = movie.title
        yearLabel.text = String(movie.releaseYear)  // movieYearLabel.text = movie.yearAsString
        if let url = movie.image {
            self.photoImageView.loadImageUsingCacheWithURLString(for: url, at: UIImage(named: "placeholder"))
        }
    }
}



