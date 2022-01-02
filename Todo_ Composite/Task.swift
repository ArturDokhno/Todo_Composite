//
//  Task.swift
//  Todo_ Composite
//
//  Created by Артур Дохно on 02.01.2022.
//

import Foundation

protocol TaskComposite {
    var taskName: String { get }
    var subtasksArray: [TaskComposite] { get }
    var countOfSubtask: Int { get }
    func addSubtask(taskName: String)
}

class Task: TaskComposite {
    
    var taskName: String
    
    var subtasksArray: [TaskComposite] = []
    
    var countOfSubtask: Int {
        return subtasksArray.count
    }
    
    init(taskName: String) {
        self.taskName = taskName
    }
    
    func addSubtask(taskName: String) {
        let task = Task(taskName: taskName)
        subtasksArray.append(task)
    }
    
    
}
