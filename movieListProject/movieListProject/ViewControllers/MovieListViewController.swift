//
//  ViewController.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController {
    
    var selectedRow: Int?
    var movieList: [MovieData]?
    let apiService = APIService()
    let apiServiceForCorData = APIServiceForCorData()
    
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Movie.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "releaseYear", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistenceService.context.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        //frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        apiService.getMoviesData { (moviesData, error) in
            if let moviesData = moviesData {
                self.movieList = moviesData.sorted { $0.releaseYear < $1.releaseYear }
                self.movieTableView.reloadData()
            }
        }
        
//        let url = "https://api.androidhive.info/json/movies.json"
//        apiServiceForCorData.getDataWithurl(url: url) { (result) in
//            switch result {
//            case .Success(let data):
//                self.saveInCoreDataWith(array: data)
//                print(data)
//            case .Error(let message):
//                DispatchQueue.main.async {
//                    self.showAlertWith(title: "Error", message: message)
//                    print(message)
//                }
//            }
//        }
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.reloadData()
        
    }
    
    
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okButton = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
//    private func createMovieEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
//        let context = PersistenceService.context.persistentContainer.viewContext
//        if let movieEntity = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie {
//            movieEntity.title = dictionary["title"] as? String
//            movieEntity.image = dictionary["image"] as? String
//            movieEntity.releaseYear = dictionary["releaseYear"] as? Int16 ?? 2019
//            movieEntity.rating = dictionary["rating"] as! Double
//            movieEntity.genre = dictionary["genre"] as? [String]
//            return movieEntity
//        }
//        return nil
//    }
    
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        //Use map to loop over a collection and apply the same operation to each element in the collection:
        
        //_ = array.map{self.createMovieEntityFrom(dictionary: $0)}
        do {
            try PersistenceService.context.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
    enum SegueIdentifier {
        static let movieDetailsSegue = "MovieDetailsSegue"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.movieDetailsSegue {
            let movieDetailsVC = segue.destination as? MovieDetailsViewController
            if let movieList = movieList {
                if let selectedRow = selectedRow {
                    movieDetailsVC?.moveToSegue(movie: movieList[selectedRow])
                }
            }
        }
    }
}


extension MovieListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if let movie = movieList?[indexPath.row] {
            cell.setInfo(movie: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width + 30 //60 = sum of labels height
    }
    
}


extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.performSegue(withIdentifier: "MovieDetailsSegue", sender: nil)
    }
}
