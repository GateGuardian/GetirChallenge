//
//  ToDoAddPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoAddPresenter {
    var view: ToDoAddViewProtocol?
    let todoService: ToDoServiceProtocol
    let validator: ToDoItemValidatorProtocol
    
    init(todoService: ToDoServiceProtocol, validator: ToDoItemValidatorProtocol) {
        self.todoService = todoService
        self.validator = validator
    }
}

//MARK: - ToDoAddPresenterProtocol
extension ToDoAddPresenter: ToDoAddPresenterProtocol {
    func attachView(_ view: ToDoAddViewProtocol) {
        self.view = view
    }
    
    func tapSaveItem(title: String, details: String) {
        do {
            try validator.validate(title: title, details: details)
            let newItem = ToDoItemDto(id: UUID().uuidString, title: title, details: details, createdAt: Date().timeIntervalSince1970)
            todoService.add(item: newItem) { (error) in
                guard error == nil else { return }
                self.view?.dismiss()
            }
        } catch let error as ToDoItemValidationError {
            view?.showErrorAlert(message: error.message())
        } catch let error as NSError {
            view?.showErrorAlert(message: error.localizedDescription)
        }
    }
}
