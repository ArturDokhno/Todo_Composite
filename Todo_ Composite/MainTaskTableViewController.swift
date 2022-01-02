//
//  MainTaskTableViewController.swift
//  Todo_ Composite
//
//  Created by Артур Дохно on 02.01.2022.
//

import UIKit

class MainTaskTableViewController: UITableViewController {
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTask))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].taskName
        cell.detailTextLabel?.text = "Subtask \(tasks[indexPath.row].countOfSubtask)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(
            withIdentifier: "SubtaskTableViewController") as! SubtaskTableViewController
        viewController.currentTask = tasks[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

//MARK: - Alert

extension MainTaskTableViewController {
    
    @objc func addTask() {
        let alertController = UIAlertController(title: "New task",
                                                message: "Enter a new task",
                                                preferredStyle: .alert)
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "Add task",
                                                style: .default) { [weak self] _ in
            guard let textTask = alertController.textFields![0].text else { return }
            let task = Task(taskName: textTask)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
}
