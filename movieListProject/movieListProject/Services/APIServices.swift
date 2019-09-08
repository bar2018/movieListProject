//
//  APIServices.swift
//  movieListProject
//
//  Created by Bar Gantovnik on 02/09/2019.
//  Copyright © 2019 Bar Gantovnik. All rights reserved.
//
import UIKit
import Foundation



struct APIService {
    
    
    enum ServiceError: Error {
        case invalidURL
    }
    
    
    func getMoviesData(completion: @escaping ([MovieData]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.androidhive.info/json/movies.json") else {
            completion(nil, ServiceError.invalidURL)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let moviesData = try decoder.decode([MovieData].self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesData, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}




class APIServiceForCorData: NSObject {
    //MARK: - Properties of class
    
    enum Result <T>{
        case Success(T)
        case Error(String)
    }
    // MARK: - Private methods
    func getDataWithurl(url: String, completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.Error("Invalid URL, we can't update your feed"))
            
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(.Error(error?.localizedDescription ?? "Error" ))
                //return completion(.Error(error!.localizedDescription))
                
            }
            guard let data = data else {
                return completion(.Error(error?.localizedDescription ?? "There are no records to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [[String: AnyObject]] {
                    completion(.Success(json))
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
        }.resume()
    }
}
