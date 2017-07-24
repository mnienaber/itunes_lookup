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

  convenience init(appName: String, descriptionText: String, devName: String, fileSize: AnyObject, image: Data, price: String
    , rating: AnyObject, url: URL, context: NSManagedObjectContext) {

    if let ent = NSEntityDescription.entity(forEntityName: "App", in: context) {
      self.init(entity: ent, insertInto: context)
      self.appName = appName
      self.descriptionText = descriptionText
      self.image = image as Data
      self.devName = devName
      self.fileSize = fileSize as AnyObject
      self.price = price
      self.rating = rating as AnyObject
      self.url = url as URL
    } else {
      fatalError("Unable to find Entity name!")
    }
  }
}
