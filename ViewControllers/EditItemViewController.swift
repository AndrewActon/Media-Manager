//
//  EditItemViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/12/23.
//

import UIKit

protocol EditDetailDelegate: AnyObject {
    func mediaItemEdited(title: String, rating: Double, year: Int, description: String)
}

class EditItemViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var yearTextField: UITextField!
    
    //MARK: Properties
    var mediaItem: MediaItem?
    var ratingValue: Double = 10.0
    weak var delegate: EditDetailDelegate?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        guard let item = mediaItem else { return }
        
        self.titleTextField.text = item.title
        self.ratingLabel.text = "Rating: \(item.rating)"
        self.yearTextField.text = "\(item.year)"
        self.descriptionTextView.text = item.itemDescription
        self.ratingSlider.value = Float(item.rating)
        descriptionTextView.keyboardType = .numberPad
    }

    //MARK: Actions
    @IBAction func ratingSliderTapped(_ sender: UISlider) {
        let roundingValue = Double(sender.value).roundTo(places: 1)
        ratingValue = roundingValue
        ratingLabel.text = "Rating \(ratingValue)"
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let delegate = delegate,
              let title = self.titleTextField.text,
              let year = self.yearTextField.text,
              let description = self.descriptionTextView.text
        else { return }
        
        if let year = Int(year) {
            delegate.mediaItemEdited(title: title, rating: ratingValue, year: year, description: description)
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Uh Oh", message: "You Have An Invalid Year. Please Correct.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(dismissAction)
            present(alert, animated: true)
        }
    }
    
    
}
