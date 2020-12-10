//
//  ToDoDetailsViewProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoDetailsViewProtocol: ToDoBaseViewProtocol {
    func populateWith(item: ToDoItemDto)
}
