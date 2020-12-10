//
//  ToDoAddPresenterProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoAddPresenterProtocol {
    func attachView(_ view: ToDoAddViewProtocol)
    func tapSaveItem(title: String, details: String)
}
