//
//  TaskCell.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//

import UIKit

class TaskCell: UITableViewCell {

    // MARK: - Variables

    // MARK: - IBOutlet
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskDoneBtn: UIButton!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCell.clipsToBounds = false
        backgroundCell.layer.cornerRadius = 15
        self.backgroundCell.backgroundColor = .systemGray6
 
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - IBActions
    
    
    
    // MARK: - Functions
    func configure(with task: Task) {
        taskName.text = task.name
        descriptionLabel.text = task.desc
        if let date = task.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            DateLbl.text = dateFormatter.string(from: date)
        } else {
            DateLbl.text = ""
        }
    }
    
    
    func configure(with task: Schedule) {
        taskName.text = task.name
        descriptionLabel.text = task.desc
        if let date = task.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            DateLbl.text = dateFormatter.string(from: date)
        } else {
            DateLbl.text = ""
        }
    }
    
    func configure(with task: Delegate) {
        taskName.text = task.name
        descriptionLabel.text = task.desc
        if let date = task.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            DateLbl.text = dateFormatter.string(from: date)
        } else {
            DateLbl.text = ""
        }
    }
    
    func configure(with task: DontDo) {
        taskName.text = task.name
        descriptionLabel.text = task.desc
        if let date = task.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            DateLbl.text = dateFormatter.string(from: date)
        } else {
            DateLbl.text = ""
        }
    }


    
}
