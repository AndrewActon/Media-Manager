//
//  MediaItemTableViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/9/23.
//

import UIKit

class MediaItemTableViewController: UITableViewController {
    
    //MARK: Properties
    var mediaItems: [MediaItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaItemCell", for: indexPath)

        let mediaItem = mediaItems[indexPath.row]
        
        cell.textLabel?.text = mediaItem.title
        cell.detailTextLabel?.text = String(mediaItem.rating)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMediaItemDetailVC" {
            let destination = segue.destination as! MediaItemDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.mediaItem = mediaItems[indexPath.row]
        }
    }
 

}
