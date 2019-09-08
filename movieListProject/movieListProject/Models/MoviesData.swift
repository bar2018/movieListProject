//
//  MoviesData.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import Foundation




    
    struct MovieData: Codable {
        
        let title: String
        let image: String?
        let rating: Double
        let releaseYear: Int
        
        let genre: [String]
        
        
       
        
        var ratingAsString: String { 
            return String(rating)
        }
        
        var yearAsString: String {
            return String(releaseYear)
        }
        
    }










