//
//  Book+CoreDataProperties.swift
//  
//
//  Created by Michael Nienaber on 7/1/17.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var apps: NSSet?

}

// MARK: Generated accessors for apps
extension Book {

    @objc(addAppsObject:)
    @NSManaged public func addToApps(_ value: App)

    @objc(removeAppsObject:)
    @NSManaged public func removeFromApps(_ value: App)

    @objc(addApps:)
    @NSManaged public func addToApps(_ values: NSSet)

    @objc(removeApps:)
    @NSManaged public func removeFromApps(_ values: NSSet)

}
