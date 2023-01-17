//
//  AddItemViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/4/23.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    //MARK: Outlets
    
    @IBOutlet weak var movieCheckBoxButton: UIButton!
    @IBOutlet weak var tvShowCheckBoxButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var isFavoriteSegmentedController: UISegmentedControl!
    @IBOutlet weak var isWatchedSegmentedController: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Properties
    var yearPickerValue: Int = Calendar.current.component(.year, from: Date())
    var isMovie: Bool = true
    var ratingValue: Double = 10.0
    var isFavorite: Bool = true
    var wasWatched: Bool = true
    
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        tvShowCheckBoxButton.imageView?.image = UIImage(systemName: "square")
    }
    
    //MARK: Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
              let mediaType = isMovie ? "Movie" : "TV Show",
              let itemDescription = descriptionTextView.text else { return }
        
        MediaItemController.shared.createMediaItem(title: title, mediaType: mediaType, year: Int64(yearPickerValue), itemDescription: itemDescription, rating: ratingValue, wasWatched: wasWatched, isFavorite: isFavorite)
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func movieCheckBoxButtonTapped(_ sender: UIButton) {
        self.movieCheckBoxButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.tvShowCheckBoxButton.imageView?.image = UIImage(systemName: "square")
        self.isMovie = true
    }
    @IBAction func tvShowCheckBoxButtonTapped(_ sender: UIButton) {
        self.movieCheckBoxButton.imageView?.image = UIImage(systemName: "square")
        self.tvShowCheckBoxButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.isMovie = false
    }
    @IBAction func ratingSliderTapped(_ sender: UISlider) {
        let roundingValue = Double(sender.value).roundTo(places: 1)
        ratingValue = roundingValue
        ratingLabel.text = "Rating: \(ratingValue)"
    }
    @IBAction func isFavoriteSegmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isFavorite = true
        } else {
            isFavorite = false
        }
    }
    @IBAction func isWatchedSegmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            wasWatched = true
        } else {
            wasWatched = false
        }
    }
    
    //MARK: Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let year = Calendar.current.component(.year, from: Date())
        return(year - 1799)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let year = Calendar.current.component(.year, from: Date())
        let yearTitle = "\(year - row)"
        return yearTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearPickerValue = (Calendar.current.component(.year, from: Date()) - row)
    }

}


extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
