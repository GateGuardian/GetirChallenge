//
//  ToDoListPresenterProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoListPresenterProtocol {
    func attachView(_ view: ToDoListViewProtocol)
    func tapAddItem()
    func tapDeleteItem(at index: Int)
    func tapDetailsItem(at index: Int)
}
