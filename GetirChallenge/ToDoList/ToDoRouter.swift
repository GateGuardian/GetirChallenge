//
//  ToDoRouter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

class ToDoRouter {
    let todoService: ToDoServiceProtocol
    weak var navigationController: UINavigationController?
    
    init(todoService: ToDoServiceProtocol) {
        self.todoService = todoService
    }
}

//MARK: - ToDoListRouterProtocol
extension ToDoRouter: ToDoListRouterProtocol {
    func showDetailsFor(item: ToDoItemDto) {
        let presenter = ToDoDetailsPresenter(todoService: todoService, router: self, item: item)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsController = storyBoard.instantiateViewController(identifier: "ToDoDetailsViewController") as! ToDoDetailsViewController
        detailsController.presenter = presenter
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func showItemCreation() {
        let presenter = ToDoAddPresenter(todoService: todoService)
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
