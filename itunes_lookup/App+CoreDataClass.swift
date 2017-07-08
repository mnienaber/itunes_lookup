//
//  App+CoreDataClass.swift
//  
//
//  Created by Michael Nienaber on 7/6/17.
//
//

import Foundation
import CoreData

public class App: NSManagedObject {

  convenience init(appName: String, descriptionText: String, devName: String, fileSize: String, image: Data, price: String
    , rating: AnyObject, context: NSManagedObjectContext) {

    if let ent = NSEntityDescription.entity(forEntityName: "App", in: context) {
      self.init(entity: ent, insertInto: context)
      self.appName = appName
      self.descriptionText = descriptionText
      self.image = image as NSData
      self.devName = devName
      self.fileSize = fileSize as String
      self.price = price
      self.rating = rating as AnyObject
    } else {
      fatalError("Unable to find Entity name!")
    }
  }
}
