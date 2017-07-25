//
//  App+CoreDataClass.swift
//  
//
//  Created by Michael Nienaber on 7/6/17.
//
//

import Foundation
import CoreData
import UIKit

public class App: NSManagedObject {

  convenience init(appName: String, descriptionText: String, devName: String, fileSize: AnyObject, image: Data, price: String
    , rating: AnyObject, url: AnyObject, context: NSManagedObjectContext) {

    if let ent = NSEntityDescription.entity(forEntityName: "App", in: context) {
      self.init(entity: ent, insertInto: context)
      self.appName = appName
      self.descriptionText = descriptionText
      self.image = image as Data
      self.devName = devName
      self.fileSize = fileSize as AnyObject
      self.price = price
      self.rating = rating as AnyObject
      self.url = url as AnyObject
    } else {
      fatalError("Unable to find Entity name!")
    }
  }

  class func coreAppWithNetworkInfo(appInfo: String, inManagedObjectContext context: NSManagedObjectContext) -> Int {
    print(appInfo)

    let delegate = UIApplication.shared.delegate as! AppDelegate
    var result = Int()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "App")
    request.predicate = NSPredicate(format: "appName = %@", appInfo as CVarArg)

    do {
      // Execute Fetch Request
      print("request: \(request)")
      let records = try delegate.stack.context.fetch(request)
      print("records: \(records.count)")
      result = records.count

    } catch {
      print("Unable to fetch managed objects for entity.")
    }
    return result
  }

}
