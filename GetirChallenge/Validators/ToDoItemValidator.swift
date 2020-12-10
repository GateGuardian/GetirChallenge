//
//  ToDoItemValidator.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 10.12.2020.
//

import Foundation

struct ToDoItemValidator: ToDoItemValidatorProtocol {
    func validate(title: String, details: String) throws {
        guard !title.isEmpty else {
            throw ToDoItemValidationError.titleEmpty
        }
        guard !details.isEmpty else {
            throw ToDoItemValidationError.detailsEmpty
        }
    }
}
