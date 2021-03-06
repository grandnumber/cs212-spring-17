//
//  Person.swift
//  TheMovieDB
//
//  Created by Jason on 1/11/15.
//

import UIKit

struct Person {
    
    struct Keys {
        static let Name = "name"
        static let ProfilePath = "profile_path"
        static let Movies = "movies"
        static let ID = "id"
    }
    
    var name = ""
    var id = 0
    
    var imagePath: String?
    var movies = [Movie]()
    
    init?(dictionary: [String : Any]) {
        
        // These prpoerties are mandatory, so we use guard
        guard
            let name = dictionary[Keys.Name] as? String,
            let id = dictionary[TMDB.Keys.ID] as? Int
            else {
                return nil
        }
        
        // This property is optional, so we allow a nil value
        let path = dictionary[Keys.ProfilePath] as? String
        
        // pass them on to the full initializer
        self.init(name: name, id: id, imagePath: path)
    }
    
    init(name: String, id: Int, imagePath: String?) {
        self.name = name
        self.id = id
        self.imagePath = imagePath
    }
}

extension Person {
    
    /**
     image is a computed property. From outside of the struct it should look like objects
     have a direct handle to their image. In fact, they store them in an imageCache. The
     cache stores the images into the documents directory, and keeps a resonable number of
     them in memory.
     */
    
    var profileImage: UIImage? {
        get {
            return TMDB.Caches.imageCache.imageWithIdentifier(imagePath)
        }
        
        set {
            TMDB.Caches.imageCache.storeImage(profileImage, withIdentifier: imagePath!)
        }
    }
}


