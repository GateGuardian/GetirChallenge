//
//  ToDoDetailsPresenterProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoDetailsPresenterProtocol {
    func attachView(_ view: ToDoDetailsViewProtocol)
    func tapAddItem()
    func tapDeleteItem()
    func tapSaveItem(item: ToDoItemDto)
}
