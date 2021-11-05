//
//  Locations+CoreDataProperties.swift
//  locationTest2
//
//  Created by Arjun TP on 2021-09-30.
//

import Foundation
import CoreData


extension Locations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged public var lattitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}

extension Locations : Identifiable {

}
