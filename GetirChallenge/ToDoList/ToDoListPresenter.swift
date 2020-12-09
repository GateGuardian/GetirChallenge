//
//  ToDoListPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoListPresenter {
    private var view: ToDoListViewProtocol?
    //todoService
    //router
    private var items = [ToDoItemDto]()
}

extension ToDoListPresenter: ToDoListPresenterProtocol {
    
    func attachView(_ view: ToDoListViewProtocol) {
        self.view = view
        //fetch stored items
    }
    
    func tapAddItem() {
        //router show add item module
        print("router show add item module")
        
        //TODO:  delete
        let randomInt = Int.random(in: 1..<100)
        items.append(ToDoItemDto(name: "name: \(randomInt)", description: ""))
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
        //router navigate to item details
        print("router navigate to item details \(index)")
    }
}
