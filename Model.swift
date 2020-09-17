//
//  Model.swift
//  ToDoAppWithCoreData
//
//  Created by 白数叡司 on 2020/09/13.
//  Copyright © 2020 AEG. All rights reserved.
//

import UIKit
import CoreData

@objc (Model)
class Model: NSManagedObject {
    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var info: String
}
