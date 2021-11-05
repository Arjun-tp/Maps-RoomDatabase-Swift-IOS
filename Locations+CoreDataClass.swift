//
//  Locations+CoreDataClass.swift
//  locationTest2
//
//  Created by Arjun TP on 2021-09-30.
//

import Foundation
import CoreData
import MapKit

@objc(Locations)
public class Locations: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(lattitude,longitude)
    }
}
