//
//  ToDoRealmService.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 10.12.2020.
//

import Foundation
import RealmSwift

class ToDoRealmService {
    var realm: Realm
    
    init?() throws {
        self.realm = try Realm()
    }
    
    //MARK: - Private
    private func addOrUpdate(item: ToDoItemDto) throws {
        try realm.write({
            realm.add(ToDoRealmItem(dto: item), update: .modified)
        })
    }
}

//MARK: - ToDoServiceProtocol
extension ToDoRealmService: ToDoServiceProtocol {
    func getToDoItems(completion: @escaping ([ToDoItemDto]) -> Void) {
        let entities = realm.objects(ToDoRealmItem.self).sorted(byKeyPath: "createdAt", ascending: true)
        let dtos: [ToDoItemDto] = entities.map { (realmItem) -> ToDoItemDto in
            return ToDoItemDto(realmItem: realmItem)
        }
        completion(dtos)
    }
    
    func add(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        do {
            try addOrUpdate(item: item)
            NotificationCenter.default.post(name: Notification.Name.ToDoItemCreated, object: nil, userInfo: nil)
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func delete(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        let success = {
            completion(nil)
            NotificationCenter.default.post(name: Notification.Name.ToDoItemDeleted, object: nil, userInfo: nil)
        }
        let entities = realm.objects(ToDoRealmItem.self).filter("id = %@", item.id)
        guard !entities.isEmpty else {
            success()
            return
        }
        do {
            try realm.write({
                realm.delete(entities)
            })
            success()
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func update(item: ToDoItemDto, completion: @escaping (Error?) -> Void) {
        do {
            try addOrUpdate(item: item)
            NotificationCenter.default.post(name: Notification.Name.ToDoItemUpdated, object: nil, userInfo: nil)
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
}
