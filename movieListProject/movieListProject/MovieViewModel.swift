//
//  MovieViewModel.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 07/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import Foundation
import CoreData

class MovieVM : NSObject  {
    
    var movies = [Movie]()
    //MARK: - Core Data Methods
    //Fetch the Data
    func fetchData(completion:@escaping (String?, Bool,_ error: NSError?)->()){
        do {
            let context = PersistenceService.context.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            do {
                self.movies = try context.fetch(fetchRequest) as? [NSManagedObject] as! [Movie]
                PersistenceService.context.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    //MARK: - TableView methods
    
    
}
