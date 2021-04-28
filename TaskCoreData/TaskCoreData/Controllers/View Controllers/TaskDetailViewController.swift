//
//  TaskDetailViewController.swift
//  TaskCoreData
//
//  Created by anthony byrd on 4/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextField: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    //MARK: - Properties
    var task: Task?
    var date: Date?
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
              let taskNote = taskNotesTextField.text, !taskNote.isEmpty,
              let taskDueDate = taskDueDatePicker?.date else {return}
        
        if let task = task {
            task.name = taskName
            task.notes = taskNote
            task.dueDate = taskDueDate
            
            TaskController.sharedInstance.updateTask(task: task, name: taskName, notes: taskNote, dueDate: taskDueDate)
        } else {
            TaskController.sharedInstance.createTaskWith(name: taskName, notes: taskNote, dueDate: taskDueDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    //MARK: - Helper Methods
    func updateView() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        taskNotesTextField.text = task.notes
        taskDueDatePicker?.date = task.dueDate ?? Date()
    }

}//End of class
