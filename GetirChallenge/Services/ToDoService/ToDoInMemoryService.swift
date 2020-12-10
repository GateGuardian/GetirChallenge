//
//  ToDoInMemoryService.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 09.12.2020.
//

import Foundation

class ToDoInMemoryService {
    var items = [ToDoItemDto]()
}

//MARK: - ToDoServiceProtocol
extension ToDoInMemoryService: ToDoServiceProtocol {
    func getToDoItems(completion: @escaping ([ToDoItemDto]) -> Void) {
        completion(items)
    }
    
    func add(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        items.append(item)
        completion(nil)
        NotificationCenter.default.post(name: Notification.Name.ToDoItemCreated, object: nil, userInfo: nil)
    }
    
    func delete(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        guard let index = items.firstIndex(where: { (toDoItem) -> Bool in
            return toDoItem.id == item.id
        }) else {
            completion(NSError(domain: "ToDoService", code: 404, userInfo: nil))
            return
        }
        items.remove(at: index)
        completion(nil)
        NotificationCenter.default.post(name: Notification.Name.ToDoItemDeleted, object: nil, userInfo: nil)
    }
    
    func update(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        items = items.map({
            if $0.id == item.id {
                return item
            }
            return $0
        })
        completion(nil)
        NotificationCenter.default.post(name: Notification.Name.ToDoItemUpdated, object: nil, userInfo: nil)
    }
}
