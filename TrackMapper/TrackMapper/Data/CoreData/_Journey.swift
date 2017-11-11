// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Journey.swift instead.

import Foundation
import CoreData

public enum JourneyAttributes: String {
    case date = "date"
}

public enum JourneyRelationships: String {
    case coordinates = "coordinates"
}

open class _Journey: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Journey"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Journey.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var date: Date?

    // MARK: - Relationships

    @NSManaged open
    var coordinates: NSSet

    open func coordinatesSet() -> NSMutableSet {
        return self.coordinates.mutableCopy() as! NSMutableSet
    }

}

extension _Journey {

    open func addCoordinates(_ objects: NSSet) {
        let mutable = self.coordinates.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.coordinates = mutable.copy() as! NSSet
    }

    open func removeCoordinates(_ objects: NSSet) {
        let mutable = self.coordinates.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.coordinates = mutable.copy() as! NSSet
    }

    open func addCoordinatesObject(_ value: Coordinate) {
        let mutable = self.coordinates.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.coordinates = mutable.copy() as! NSSet
    }

    open func removeCoordinatesObject(_ value: Coordinate) {
        let mutable = self.coordinates.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.coordinates = mutable.copy() as! NSSet
    }

}

