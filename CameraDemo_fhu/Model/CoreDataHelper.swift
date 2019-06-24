//
//  CoreDataUtilities.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/24.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
  public class func saveImageToDB(image: UIImage, imageName: String, shootDate: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      print(#function + " failed to get appDelegate.")
      return
    }
    let context = appDelegate.persistentContainer.viewContext
    
    //Insert data into Entity
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context)
    // Save values getting from database
    entity.setValue(imageName, forKey: "title")
    entity.setValue(shootDate, forKey: "shootDate")
    entity.setValue(image.pngData(), forKey: "image")
    
    do{
      try context.save()
      print("Image saved successfully.")
    }
    catch{
      print("Failed in saving the image.")
    }
  }
  
  public class func retrieveImageFromDB() -> [NSManagedObject?] {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      print(#function + " failed to get appDelegate.")
      return []
    }
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
    request.returnsObjectsAsFaults = false;
    
    do {
      let results = try context.fetch(request)
      if results.count > 0 {
        guard let result = results as? [NSManagedObject] else {
          print(#function + " failed to get results when retrieve from database.")
          return []
        }
        return result
      }
    }
    catch {
      print(#function + " Error occurred when retrieve from database.")
    }
    return []
  }
}
