//
//  ToDoListViewController.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

private let ListTitle = "List"

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: ToDoListPresenterProtocol?
    
    private var items = [ToDoItemDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.attachView(self)
        setupNavigationBar()
    }
    
    //MARK: - Actions
    
    @objc private func didTapAdd() {
        presenter?.tapAddItem()
    }
    
    //MARK: - Private
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        self.title = ListTitle
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem = addButton
    }
}

//MARK: - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        presenter?.tapDeleteItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.tapDetailsItem(at: indexPath.row)
    }
}

//MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
}


//MARK: - ToDoListViewProtocol
extension ToDoListViewController: ToDoListViewProtocol {
    func showItems(_ items: [ToDoItemDto]) {
        self.items = items
        self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.fade)
    }
}
