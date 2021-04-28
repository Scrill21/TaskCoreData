//
//  TaskTableViewCell.swift
//  TaskCoreData
//
//  Created by anthony byrd on 4/27/21.
//

import UIKit
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: - Properties
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
    //MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    //MARK: - Helper Methods
    func updateView() {
        guard let task = task else {return}
        taskNameLabel.text = task.name
        
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
}//End of class
