//
//  ToDoDetailsPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoDetailsPresenter {
    var router: ToDoDetailsRouterProtocol
    var todoService: ToDoServiceProtocol
    var item: ToDoItemDto
    private weak var view: ToDoDetailsViewProtocol?
    
    init(todoService: ToDoServiceProtocol, router: ToDoDetailsRouterProtocol, item: ToDoItemDto) {
        self.todoService = todoService
        self.router = router
        self.item = item
    }
}

//MARK: - ToDoDetailsPresenterProtocol
extension ToDoDetailsPresenter: ToDoDetailsPresenterProtocol {
    func attachView(_ view: ToDoDetailsViewProtocol) {
        self.view = view
        view.populateWith(item: self.item)
    }
    
    func tapAddItem() {
        router.showItemCreation()
    }
    
    func tapDeleteItem() {
        todoService.delete(item: item) { (error) in
            //TODO: error handling
            self.router.dismissDetails()
        }
    }
    
    func tapSaveItem(item: ToDoItemDto) {
        todoService.update(item: item) { (error) in
            //TODO: error handling
            self.view?.populateWith(item: item)
        }
    }
}

