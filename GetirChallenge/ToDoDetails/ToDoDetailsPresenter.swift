//
//  ToDoDetailsPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoDetailsPresenter {
    let router: ToDoDetailsRouterProtocol
    let todoService: ToDoServiceProtocol
    let validator: ToDoItemValidatorProtocol
    var item: ToDoItemDto
    private weak var view: ToDoDetailsViewProtocol?
    
    init(todoService: ToDoServiceProtocol, router: ToDoDetailsRouterProtocol, validator: ToDoItemValidatorProtocol, item: ToDoItemDto) {
        self.todoService = todoService
        self.router = router
        self.validator = validator
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
            if let error = error {
                self.view?.showErrorAlert(message: error.localizedDescription)
                return
            }
            self.router.dismissDetails()
        }
    }
    
    func tapSaveItem(title: String, details: String) {
        do {
            try validator.validate(title: title, details: details)
            let updatetd = ToDoItemDto(id: item.id, title: title, details: details, createdAt: item.createdAt)
            todoService.update(item: item) { (error) in
                if let error = error {
                    self.view?.showErrorAlert(message: error.localizedDescription)
                    return
                }
                self.view?.populateWith(item: updatetd)
            }
        } catch let error as ToDoItemValidationError {
            view?.showErrorAlert(message: error.message())
        } catch let error as NSError {
            view?.showErrorAlert(message: error.localizedDescription)
        }
    }
}
