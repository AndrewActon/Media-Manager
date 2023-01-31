//
//  DatePickerViewController.swift
//  MediaManager
//
//  Created by Andrew Acton on 1/30/23.
//

import UIKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func reminderDateEdited(date: Date)
}

class DatePickerViewController: UIViewController {

    //MARK: - Properties
    var date: Date?
    weak var delegate: DatePickerViewControllerDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Methods
    func setupViews() {
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    //MARK: - Actions
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        self.date = sender.date
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let date = date,
              let delegate = delegate else { return }
        delegate.reminderDateEdited(date: date)
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
