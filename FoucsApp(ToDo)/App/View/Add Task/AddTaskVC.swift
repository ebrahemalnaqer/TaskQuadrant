//
//  AddTaskVC.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//

import UIKit

protocol AddTaskDelegate: AnyObject {
    func didAddTask(name: String, description: String,date: Date)
}

class AddTaskVC: UIViewController {
    // MARK: - Variables
    weak var delegate: AddTaskDelegate?

    // MARK: - IBOutlet
    
    @IBOutlet weak var TaskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var nameDescriptionContainerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBActions
    @IBAction func AddTaskBtn(_ sender: Any) {
        guard let name = TaskNameTextField.text, !name.isEmpty,
                let description = taskDescriptionTextField.text else {
                // Handle empty fields
                // Show an alert to inform the user
                let alert = UIAlertController(title: "Validation Error", message: "Please fill in Task Name fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Call the delegate method to send the data back
            delegate?.didAddTask(name: name, description: description, date: datePicker.date)
            // Dismiss the current view controller
           navigationController?.popViewController(animated: true)
            // Dismiss the current view controller
            dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
}
