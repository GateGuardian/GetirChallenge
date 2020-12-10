//
//  ToDoRouter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

class ToDoRouter {
    let todoService: ToDoServiceProtocol
    let validator: ToDoItemValidatorProtocol
    weak var navigationController: UINavigationController?
    
    init(todoService: ToDoServiceProtocol, validator: ToDoItemValidatorProtocol) {
        self.todoService = todoService
        self.validator = validator
    }
}

//MARK: - ToDoListRouterProtocol
extension ToDoRouter: ToDoListRouterProtocol {
    func showDetailsFor(item: ToDoItemDto) {
        let presenter = ToDoDetailsPresenter(todoService: todoService, router: self, validator: validator, item: item)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsController = storyBoard.instantiateViewController(identifier: "ToDoDetailsViewController") as! ToDoDetailsViewController
        detailsController.presenter = presenter
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func showItemCreation() {
        let presenter = ToDoAddPresenter(todoService: todoService, validator: validator)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addController = storyBoard.instantiateViewController(identifier: "ToDoAddViewController") as! ToDoAddViewController
        addController.presenter = presenter
        navigationController?.present(addController, animated: true, completion: nil)
    }
}

//MARK: - ToDoDetailsRouterProtocol
extension ToDoRouter: ToDoDetailsRouterProtocol {
    func dismissDetails() {
        navigationController?.popViewController(animated: true)
    }
}
