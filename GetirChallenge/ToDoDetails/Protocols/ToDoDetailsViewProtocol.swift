//
//  ToDoDetailsViewProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoDetailsViewProtocol: class {
    func populateWith(item: ToDoItemDto)
}
