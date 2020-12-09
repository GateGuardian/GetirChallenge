//
//  ToDoRouter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import UIKit

class ToDoRouter {
    //services and providers container
    weak var navigationController: UINavigationController?
}


//MARK: - ToDoListRouterProtocol
extension ToDoRouter: ToDoListRouterProtocol {
    func showDetailsFor(item: ToDoItemDto) {
        //assemble details module
        let presenter = ToDoDetailsPresenter(router: self, item: item)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailsController = storyBoard.instantiateViewController(identifier: "ToDoDetailsViewController") as! ToDoDetailsViewController
        detailsController.presenter = presenter
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func showItemCreation() {
        //TODO: implement
        print("router show item creation")
    }
}

//MARK: - ToDoDetailsRouterProtocol
extension ToDoRouter: ToDoDetailsRouterProtocol {
    func dismissDetails() {
        navigationController?.popViewController(animated: true)
    }
}
