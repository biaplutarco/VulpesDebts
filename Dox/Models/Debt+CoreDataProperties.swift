//
//  Debt+CoreDataProperties.swift
//  Dox
//
//  Created by Bia Plutarco on 29/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//
//

import Foundation
import CoreData

extension Debt {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Debt> {
        return NSFetchRequest<Debt>(entityName: "Debt")
    }

    @NSManaged public var name: String
    @NSManaged public var reason: String
    @NSManaged public var type: Int
    @NSManaged public var value: String
}
