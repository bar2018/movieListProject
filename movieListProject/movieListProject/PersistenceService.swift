//
//  PersistenceService.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 03/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import Foundation
import CoreData


class PersistenceService: NSObject {
    
    // MARK: - Core Data stack
   
    static let context = PersistenceService()
    private override init() {}// Prevent clients from creating another instance.
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "movieListProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
      func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
