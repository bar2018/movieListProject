//
//  Movie+CoreDataProperties.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 03/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//
//

import Foundation
import CoreData

//https://github.com/alonhrri/TingzTest
extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseYear: Int16
    @NSManaged public var genre: [String]?

    
    var yearAsString: String {
        return String(releaseYear)
    }
    
    var ratingAsString: String {
        return String(rating)
    }
}
