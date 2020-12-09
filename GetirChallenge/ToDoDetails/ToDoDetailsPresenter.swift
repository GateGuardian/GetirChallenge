//
//  ToDoDetailsPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoDetailsPresenter {
    var router: ToDoDetailsRouterProtocol
    var item: ToDoItemDto
    private weak var view: ToDoDetailsViewProtocol?
    //todoService
    
    init(router: ToDoDetailsRouterProtocol, item: ToDoItemDto) {
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
        //TODO: service delete item
        router.dismissDetails()
    }
    
    func tapSaveItem(item: ToDoItemDto) {
        //TODO: service save item
        view?.populateWith(item: item)
    }
}

