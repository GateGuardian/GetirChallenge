//
//  ToDoServiceProtocol.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

protocol ToDoServiceProtocol {
    func getToDoItems(completion: @escaping (_ enteties: [ToDoItemDto]) -> Void)
    func add(item: ToDoItemDto, completion: @escaping (_ error: Error?) -> Void)
    func delete(item: ToDoItemDto, completion: @escaping (_ error: Error?) -> Void)
    func update(item: ToDoItemDto, completion: @escaping (_ error: Error?) -> Void)
}

extension Notification.Name {
    public static let ToDoItemCreated = Notification.Name("ToDoItemCreated")
    public static let ToDoItemUpdated = Notification.Name("ToDoItemUpdated")
    public static let ToDoItemDeleted = Notification.Name("ToDoItemDeleted")
}
