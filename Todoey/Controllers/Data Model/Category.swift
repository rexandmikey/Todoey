//
//  Category.swift
//  Todoey
//
//  Created by Hye sun Chung on 28/6/2018.
//  Copyright © 2018 Hye sun Chung. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
