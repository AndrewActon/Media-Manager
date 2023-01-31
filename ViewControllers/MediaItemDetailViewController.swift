//
//  MediaItemDetailViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/9/23.
//

import UIKit

protocol DeleteItemDelegate: AnyObject {
    func deleteItem(mediaItem: MediaItem)
}

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
    weak var delegate: (DeleteItemDelegate)?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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

    //MARK: Actions
    @IBAction func isFavoriteButtonTapped(_ sender: UIButton) {
        guard let item = mediaItem else { return }
        if item.isFavorite {
            mediaItem?.isFavorite = false
        } else {
            mediaItem?.isFavorite = true
        }
        
        MediaItemController.shared.updateMediaItem()
        
        if mediaItem?.isFavorite == true {
            isFavoriteButton.setTitle("Remove From Favorites", for: .normal)
        } else {
            isFavoriteButton.setTitle("Add To Favorites", for: .normal)
        }
    }
    
    @IBAction func isWatchedButtonTapped(_ sender: UIButton) {
        guard let item = mediaItem else { return }
        if item.wasWatched {
            mediaItem?.wasWatched = false
        } else {
            mediaItem?.wasWatched = true
        }
        
        MediaItemController.shared.updateMediaItem()
        
        if mediaItem?.wasWatched == true {
            isWatchedButton.setTitle("Mark As Unwatched", for: .normal)
        } else {
            isWatchedButton.setTitle("Mark As Watched", for: .normal)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let item = mediaItem else { return }
        MediaItemController.shared.deleteMediaItem(mediaItem: item)
        delegate?.deleteItem(mediaItem: item)
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditItemVC" {
            let destination = segue.destination as! EditItemViewController
            destination.mediaItem = mediaItem
            destination.delegate = self
        } else if segue.identifier == "toReminderView" {
            let destination = segue.destination as! DatePickerViewController
            destination.delegate = self
            destination.date = mediaItem?.reminderDate
        }
    }

}

extension MediaItemDetailViewController: EditDetailDelegate {
    func mediaItemEdited(title: String, rating: Double, year: Int, description: String) {
        guard let mediaItem = self.mediaItem else { return }
        mediaItem.title = title
        mediaItem.rating = rating
        mediaItem.year = Int64(year)
        mediaItem.itemDescription = description
        
        MediaItemController.shared.updateMediaItem()
        setupViews()
    }
}

extension MediaItemDetailViewController: DatePickerViewControllerDelegate {
    func reminderDateEdited(date: Date) {
        guard let mediaItem = mediaItem else { return }
        mediaItem.reminderDate = date
        reminderButton.setTitle("Edit Watch Reminder", for: .normal)
        MediaItemController.shared.updateMediaItemReminderDate(mediaItem: mediaItem)
    }
}
