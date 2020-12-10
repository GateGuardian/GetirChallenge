//
//  ToDoListPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoListPresenter {
    var router: ToDoListRouterProtocol
    var todoService: ToDoServiceProtocol
    private weak var view: ToDoListViewProtocol?
    
    private var items = [ToDoItemDto]()
    
    init(router: ToDoListRouterProtocol, todoService: ToDoServiceProtocol) {
        self.router = router
        self.todoService = todoService
        setup()
    }
    
    //MARK: - Private
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(todosUpdated(notification:)), name: Notification.Name.ToDoItemUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todosUpdated(notification:)), name: Notification.Name.ToDoItemCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todosUpdated(notification:)), name: Notification.Name.ToDoItemDeleted, object: nil)
    }
    
    @objc private func todosUpdated(notification: Notification) {
        fetchToDoItems()
    }
    
    private func fetchToDoItems() {
        todoService.getToDoItems { (items) in
            self.items = items
            self.view?.showItems(items)
        }
    }
}

//MARK: - ToDoListPresenterProtocol
extension ToDoListPresenter: ToDoListPresenterProtocol {
    func attachView(_ view: ToDoListViewProtocol) {
        self.view = view
        fetchToDoItems()
    }
    
    func tapAddItem() {
        router.showItemCreation()
    }
    
    func tapDeleteItem(at index: Int) {
        guard 0 ... (items.count - 1) ~= index else { return }
        let itemToDelete = items[index]
        todoService.delete(item: itemToDelete) { (error) in }
    }
    
    func tapDetailsItem(at index: Int) {
        guard 0 ... (items.count - 1) ~= index else { return }
        let item = items[index]
        router.showDetailsFor(item: item)
    }
}
