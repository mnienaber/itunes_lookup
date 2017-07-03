//
//  App+CoreDataClass.swift
//  
//
//  Created by Michael Nienaber on 7/1/17.
//
//

import Foundation
import CoreData

public class App: NSManagedObject {

  convenience init(appName: String, descriptionText: String, devName: String, fileSize: Double, image: Data, price: String
    , rating: Double, context: NSManagedObjectContext) {

    if let ent = NSEntityDescription.entity(forEntityName: "App", in: context) {
      self.init(entity: ent, insertInto: context)
      self.appName = appName
      self.descriptionText = descriptionText
      self.image = image
      self.devName = devName
      self.fileSize = fileSize
      self.price = price
      self.rating = rating
    } else {
      fatalError("Unable to find Entity name!")
    }

  }

}
