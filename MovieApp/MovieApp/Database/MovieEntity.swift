//
//  MovieEntity.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 23/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    @objc dynamic var code = 0
    @objc dynamic var imagePath = ""
    
    static func save(code: Int, imagePath: String) {
        let movieEntity = MovieEntity()
        movieEntity.code = code
        movieEntity.imagePath = imagePath
        
        let realm = try! Realm()
        
        let savedMovie = realm.objects(MovieEntity.self).filter("code == \(code)").first
        
        if savedMovie == nil {
            try! realm.write {
                realm.add(movieEntity)
            }
        }
    }
    
    static func remove(code: Int) {
        let realm = try! Realm()
        let savedMovie = realm.objects(MovieEntity.self).filter("code == \(code)").first
        
        if let savedMovie = savedMovie {
            try! realm.write {
                realm.delete(savedMovie)
            }
        }
    }
    
    static func all() -> [Movie] {
        let realm = try! Realm()
        let savedMovies = realm.objects(MovieEntity.self)
        var movies = [Movie]()
        
        for savedMovie in savedMovies {
            let movie = Movie()
            movie.id = savedMovie.code
            movie.posterPath = savedMovie.imagePath
            
            movies.append(movie)
        }
        
        return movies
    }
    
    static func isSaved(code: Int) -> Bool {
        let realm = try! Realm()
        let savedMovie = realm.objects(MovieEntity.self).filter("code == \(code)").first
        
        if savedMovie == nil {
            return false
        } else {
            return true
        }
    }
    
    static func removeAll() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func saveOrRemove(code: Int, imagePath: String) -> Bool {
        let movieEntity = MovieEntity()
        movieEntity.code = code
        movieEntity.imagePath = imagePath
        
        let realm = try! Realm()
        
        let savedMovie = realm.objects(MovieEntity.self).filter("code == \(code)").first
        
        if let savedMovie = savedMovie {
            try! realm.write {
                realm.delete(savedMovie)
            }
            return false
        } else {
            try! realm.write {
                realm.add(movieEntity)
            }
            return true
        }
    }
}
