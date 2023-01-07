//
//  MediaItemController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/4/23.
//

import CoreData

class MediaItemController {
    
    //MARK: Shared Instance
    static let shared = MediaItemController()
    
    //MARK: Properties
    var mediaItems: [MediaItem] = []
    var favorites: [MediaItem] = []
    var movies: [MediaItem] = []
    var tvShows: [MediaItem] = []
    var sections: [[MediaItem]]{[favorites, movies, tvShows]}
    
    private init() {
        fetchMediaItems()
    }
    
    private lazy var fetchRequest: NSFetchRequest<MediaItem> = {
        let request = NSFetchRequest<MediaItem>(entityName: "MediaItem")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: Helper Functions
    
    func sectionOffMediaItems() {
        for i in mediaItems {
            if i.isFavorite == true {
                favorites.append(i)
            }
            if i.mediaType == "Movie" {
                movies.append(i)
            } else {
                tvShows.append(i)
            }
        }
    }
    
    //MARK: CRUD
    
    //Create
    func createMediaItem(title: String, mediaType: String, year: Int64, itemDescription: String, rating: Double, wasWatched: Bool, isFavorite: Bool) {
        let mediaItem = MediaItem(title: title, mediaType: mediaType, year: year, rating: rating, itemDescription: itemDescription, isFavorite: isFavorite, wasWatched: wasWatched)
        mediaItems.append(mediaItem)
        CoreDataStack.saveContext()
        fetchMediaItems()
    }
    
    
    //Read
    func fetchMediaItems(){
        //set empty arrays
        favorites = []
        movies = []
        tvShows = []
        
        //set arrays with fetched values
        let mediaItems = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.mediaItems = mediaItems
        sectionOffMediaItems()
    }
    
    //Update
    
    //Delete
    
    
}
