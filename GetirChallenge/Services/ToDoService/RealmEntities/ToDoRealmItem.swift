//
//  ToDoRealmItem.swift
//  GetirChallenge
//
//  Created by Ivan Kostromin on 10.12.2020.
//

import Foundation
import RealmSwift

class ToDoRealmItem: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var details: String = ""
    @objc dynamic var createdAt: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String, title: String, details: String, createdAt: Double) {
        self.init()
        self.id = id
        self.title = title
        self.details = details
        self.createdAt = createdAt
    }
}

extension ToDoRealmItem {
    convenience init(dto: ToDoItemDto) {
        self.init(id: dto.id, title: dto.title, details: dto.details, createdAt: dto.createdAt)
    }
}

extension ToDoItemDto {
    init(realmItem: ToDoRealmItem) {
        self.init(id: realmItem.id, title: realmItem.title, details: realmItem.details, createdAt: realmItem.createdAt)
    }
}
