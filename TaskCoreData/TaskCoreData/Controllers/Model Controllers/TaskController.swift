//
//  TaskController.swift
//  TaskCoreData
//
//  Created by anthony byrd on 4/27/21.
//

import CoreData

class TaskController {
    
    //MARK: - Properties
    static let sharedInstance = TaskController()
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - CRUD
    /*
     Create the following CRUD function signatures:
     createTaskWith(name: String, notes: String?, dueDate: Date?)
     fetchTasks()
     update(task: Task, name: String, notes: String?, dueDate: Date?)
     toggleIsComplete(task: Task)
     */
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.tasks = tasks
    }
    
    func updateTask(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func deleteTask(with task: Task) {
        guard let index = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: index)
        CoreDataStack.context.delete(task)
        
        CoreDataStack.saveContext()
    }
}//End of class
