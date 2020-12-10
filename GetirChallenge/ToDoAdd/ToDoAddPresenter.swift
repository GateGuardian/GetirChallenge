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
    
    init(todoService: ToDoServiceProtocol) {
        self.todoService = todoService
    }
}

//MARK: - ToDoAddPresenterProtocol
extension ToDoAddPresenter: ToDoAddPresenterProtocol {
    func attachView(_ view: ToDoAddViewProtocol) {
        self.view = view
    }
    
    func tapSaveItem(item: ToDoItemDto) {
        todoService.add(item: item) { (error) in
            guard error == nil else { return }
            self.view?.dismiss()
        }
        
    }
}
