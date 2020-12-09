//
//  ToDoListPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoListPresenter {
    var router: ToDoListRouterProtocol
    private weak var view: ToDoListViewProtocol?
    //todoService
    
    private var items = [ToDoItemDto]()
    
    init(router: ToDoListRouterProtocol) {
        self.router = router
    }
}

//MARK: - ToDoListPresenterProtocol
extension ToDoListPresenter: ToDoListPresenterProtocol {
    func attachView(_ view: ToDoListViewProtocol) {
        self.view = view
        //fetch stored items
    }
    
    func tapAddItem() {
        //router show add item module
        print("router show add item module")
        //TODO: delete
        let randomInt = Int.random(in: 1..<100)
        items.append(ToDoItemDto(title: "name: \(randomInt)", details: ""))
        view?.showItems(items)
    }
    
    func tapDeleteItem(at index: Int) {
        //index out of bounds check
        //todoService delete item
        print("todoService delete item \(index)")
        items.remove(at: index)
        view?.showItems(items)
    }
    
    func tapDetailsItem(at index: Int) {
        //index out of bounds check
        //router navigate to item details
        print("router navigate to item details \(index)")
        let item = items[index]
        router.showDetailsFor(item: item)
    }
}
