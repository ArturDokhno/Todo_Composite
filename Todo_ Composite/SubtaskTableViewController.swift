//
//  SubtaskTableViewController.swift
//  Todo_ Composite
//
//  Created by Артур Дохно on 02.01.2022.
//

import UIKit

class SubtaskTableViewController: UITableViewController {

    var currentTask: TaskComposite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentTask?.taskName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentTask = currentTask else { return 0 }
        return currentTask.countOfSubtask
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Subtask") else { return UITableViewCell() }
        guard let currentTask = currentTask else { return UITableViewCell() }
        
        cell.textLabel?.text = currentTask.subtasksArray[indexPath.row].taskName
        cell.detailTextLabel?.text = "Subtask \(currentTask.subtasksArray[indexPath.row].countOfSubtask)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(
            withIdentifier: "SubtaskTableViewController") as! SubtaskTableViewController
        guard let currentTask = currentTask else { return }
        viewController.currentTask = currentTask.subtasksArray[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

//MARK: - Alert

extension SubtaskTableViewController {
    
    @objc func addTask() {
        let alertController = UIAlertController(title: "New subtask",
                                                message: "Add a new subtsk",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Add task",
                                                style: .default) { [weak self] _ in
            guard let textTask = alertController.textFields![0].text else { return }
            self?.currentTask?.addSubtask(taskName: textTask)
            self?.tableView.reloadData()
        })
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
}
