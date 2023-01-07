//
//  MediaItem+Convenience.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/4/23.
//

import CoreData

extension MediaItem {
    @discardableResult convenience init (title: String, mediaType: String, year: Int64, rating: Double, itemDescription: String, isFavorite: Bool, wasWatched: Bool, reminderDate: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context){
            self.init(context: context)
        self.title = title
        self.mediaType = mediaType
        self.year = year
        self.rating = rating
        self.itemDescription = itemDescription
        self.isFavorite = isFavorite
        self.reminderDate = reminderDate
        self.id = UUID()
        self.wasWatched = wasWatched
    }
    
}
