//
//  ToDoAddPresenter.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoAddPresenter {
    var view: ToDoAddViewProtocol?
    //todoService
}

//MARK: - ToDoAddPresenterProtocol
extension ToDoAddPresenter: ToDoAddPresenterProtocol {
    func attachView(_ view: ToDoAddViewProtocol) {
        self.view = view
    }
    
    func tapSaveItem(item: ToDoItemDto) {
        //service save item
        view?.dismiss()
    }
}
