// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Coordinate.swift instead.

import Foundation
import CoreData

public enum CoordinateAttributes: String {
    case latitude = "latitude"
    case longitude = "longitude"
}

public enum CoordinateRelationships: String {
    case journey = "journey"
}

open class _Coordinate: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Coordinate"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Coordinate.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var latitude: NSNumber?

    @NSManaged open
    var longitude: NSNumber?

    // MARK: - Relationships

    @NSManaged open
    var journey: Journey?

}

