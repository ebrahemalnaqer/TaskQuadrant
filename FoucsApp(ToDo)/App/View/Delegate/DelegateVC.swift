//
//  DelegateVC.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 11/09/2023.
//

import UIKit

class DelegateVC: UIViewController {

    // MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Assuming your TaskVC has an array to store tasks
    var tasks: [Delegate] = []
      

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call getAllItems to load tasks from Core Data
        getAllItems()
        setupUI()
        configureTabelView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    //MARK: - configure TabelView
    func configureTabelView(){
        tableView.dataSource = self
        tableView.delegate = self
        // Register the custom cell class
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    // MARK: - IBActions

    @IBAction func addBtn(_ sender: Any) {
        let viewc = AddTaskVC()
        viewc.delegate = self // delegate
        nav(viewc)
    }
    
    
    // MARK: - Functions
    private func setupUI() {
        // Create a UIColor directly using RGB values
//        let color = UIColor(red: CGFloat(111) / 255.0,green: CGFloat(126) / 255.0,blue: CGFloat(110) / 255.0,alpha: 1.0)
//        self.tableView.backgroundColor = color
        
       }
    
    

}

//MARK: - Extension
extension DelegateVC : UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit Your Item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Task Name"
                textField.text = selectedTask.name
            })
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Task Description"
                textField.text = selectedTask.desc
            })
            
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
                guard let self = self,
                      let nameField = alert.textFields?.first,
                      let descriptionField = alert.textFields?.last,
                      let newName = nameField.text,
                      let newDescription = descriptionField.text,
                      !newName.isEmpty, !newDescription.isEmpty else {
                    return
                }
                self.updateItem(item: selectedTask, newName: newName, newDescription: newDescription)
            }))
            
            self.present(alert, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: selectedTask)
        }))
        
        present(sheet, animated: true)
    }
}

extension DelegateVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell // Dequeue the custom cell
        
        let task = tasks[indexPath.row]
        
        // Configure the custom cell with task data
        cell.taskName.text = task.name
        
        cell.taskDoneBtn.tag = indexPath.row // Set a unique tag to identify the button
 
        cell.taskDoneBtn.addTarget(self, action: #selector(taskDoneBtnTapped(_:)), for: .touchUpInside) // Add target action
        
        cell.configure(with: task) // Configure the cell with task data
        
        // Apply strikethrough style to the task name if it's completed
        let attributedText: NSAttributedString
        if task.isCompleted {
            attributedText = NSAttributedString(string: task.name ?? "",
                                                attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.layer.cornerRadius = 20
            cell.contentView.backgroundColor = UIColor.lightGray // Set background color for completed tasks
        } else {
            attributedText = NSAttributedString(string: task.name ?? "")
//            cell.contentView.backgroundColor = UIColor.white // Set background color for non-completed tasks
        }
        // Set the button image based on the task's completion status
        let image = task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        cell.taskDoneBtn.setImage(image, for: .normal)
        // Set the attributed text for the task's name
        cell.taskName.attributedText = attributedText
        cell.detailTextLabel?.text = task.desc
        return cell
    }

    @objc func taskDoneBtnTapped(_ sender: UIButton) {
        let index = sender.tag
           tasks[index].isCompleted.toggle()
           let indexPath = IndexPath(row: index, section: 0)
           tableView.reloadRows(at: [indexPath], with: .automatic)
           
           if let cell = tableView.cellForRow(at: indexPath) as? TaskCell {
               let image = tasks[index].isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
               cell.taskDoneBtn.setImage(image, for: .normal)
           }
    }
    

    
}

extension DelegateVC: AddTaskDelegate {
   
    

    func didAddTask(name: String, description: String, date: Date) {
        // Create a new task
        let newTask = Delegate(context: context)
        newTask.name = name
        newTask.desc = description
        newTask.date = date
        newTask.isCompleted = false // You can set the initial completion status as needed
        
        // Save the new task to Core Data
        do {
            try context.save()
            tasks.append(newTask) // Add the new task to the tasks array
            getAllItems()
            tableView.reloadData() // Refresh the table view
        } catch {
            print("Error saving task: \(error)")
        }
    }
}


// MARK: - Core Data Methods

extension DelegateVC {
    
    func getAllItems() {
        do {
            tasks = try context.fetch(Delegate.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // Handle error
        }
    }
    
    func createItem(name: String, desc: String) {
        let newItem = Delegate(context: context)
        newItem.name = name
        newItem.desc = desc
        
        do {
            try context.save()
            getAllItems()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func deleteItem(item: Delegate) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        } catch {
            // Handle error
        }
    }
    
    func updateItem(item: Delegate, newName: String, newDescription: String) {
        item.name = newName
        item.desc = newDescription
        do {
            try context.save()
            getAllItems()
        } catch {
            // Handle error
        }
    }
}

