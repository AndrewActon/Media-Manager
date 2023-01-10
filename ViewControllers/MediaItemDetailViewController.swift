//
//  MediaItemDetailViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/9/23.
//

import UIKit

class MediaItemDetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var mediaRating: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var mediaTextDescription: UITextView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var isWatchedButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: Properties
    var mediaItem: MediaItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        guard let item = mediaItem else { return }
        
        self.mediaTitle.text = item.title
        self.mediaRating.text = String(item.rating)
        self.releaseYear.text = "Released in \(item.year)"
        self.mediaTextDescription.text = item.itemDescription
        mediaTextDescription.isEditable = false
        
        if item.mediaType == "Movie" {
            self.deleteButton.setTitle("Delete Movie", for: .normal)
        } else {
            self.deleteButton.setTitle("Delete TV Show", for: .normal)
        }
        
        if item.isFavorite {
            self.isFavoriteButton.setTitle("Remove From Favorites", for: .normal)
        } else {
            self.isFavoriteButton.setTitle("Add To Favorites", for: .normal)
        }
        
        if item.wasWatched {
            self.isWatchedButton.setTitle("Mark As Unwatched", for: .normal)
        } else {
            self.isWatchedButton.setTitle("Mark As Watched", for: .normal)
        }
    }

}
