//
//  ToDoListViewProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoListViewProtocol: class {
    func showItems(_ items: [ToDoItemDto])
}
