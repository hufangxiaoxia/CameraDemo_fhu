//
//  GalleryViewController.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/19.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  var data = [NSManagedObject?]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    data = CoreDataHelper.retrieveImageFromDB()
    tableView.reloadData()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pictureTableViewCell") as! PictureTableViewCell
    cell.photoName.text = data[indexPath.row]?.value(forKey: "title") as? String
    cell.shootDate.text = data[indexPath.row]?.value(forKey: "shootDate") as? String
    guard let image = data[indexPath.row]?.value(forKey: "image") as? Data else {
      print(#function + " failed to get image data for selected cell.")
      return cell
    }
    let photoImage = UIImage(data: image as Data)
    cell.photoImageView.image = photoImage
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let photoName = data[indexPath.row]?.value(forKey: "title") as? String,
      let shootDate = data[indexPath.row]?.value(forKey: "shootDate") as? String,
      let imageData = data[indexPath.row]?.value(forKey: "image") as? Data,
      let photoImage = UIImage(data: imageData) else {
        print(#function + " Error occurred when fetching the detail information for selected photo.")
        return
    }
    let photoModel = PhotoModel(photoImage: photoImage, photoName: photoName, shootDate: shootDate)
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let photoDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as? PhotoDetailsViewController else {
      print(#function + " failed to create photoDetailsViewController.")
      return
    }
    
    present(photoDetailsViewController, animated: true, completion: nil)
    photoDetailsViewController.setup(photoDetails: photoModel)
  }
}
