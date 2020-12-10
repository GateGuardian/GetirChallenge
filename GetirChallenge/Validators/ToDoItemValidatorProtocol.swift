//
//  ToDoItemValidatorProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 10.12.2020.
//

import Foundation

protocol ToDoItemValidatorProtocol {
    func validate(title: String, details: String) throws
}

enum ToDoItemValidationError: Error {
    case titleEmpty
    case detailsEmpty
    
    func message() -> String {
        switch self {
        case .titleEmpty:
            return "Title is empty"
        case .detailsEmpty:
            return "Details is empty"
        }
    }
}
