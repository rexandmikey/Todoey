//
//  Item.swift
//  Todoey
//
//  Created by Hye sun Chung on 28/6/2018.
//  Copyright © 2018 Hye sun Chung. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
